using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Prism.Commands;
using System.Windows;
using System.Diagnostics;
using Prism.Commands;
using Prism.Ioc;
using System.Diagnostics;
using Microsoft.Win32;
using System.IO;
using System.ComponentModel;
using Microsoft.WindowsAPICodePack.Dialogs;

namespace MyToDo1.ViewModels
{
    partial class ProcessViewModel : NavigationViewModel
    {
        private IRegionManager regionManager;
        public DelegateCommand NavigateToPreviewCommand { get; private set; }

        // 保存用户选中的图片绝对路径
        private string _selectedImagePath;

        // 保存启动的 Python 服务端进程引用
        private Process _pythonCVProcess;
        private int _lowerH;
        public int LowerH
        {
            get => _lowerH;
            set
            {
                if (_lowerH != value)
                {
                    _lowerH = value;
                    OnPropertyChanged(nameof(LowerH));
                }
            }
        }

        private int _lowerS;
        public int LowerS
        {
            get => _lowerS;
            set
            {
                if (_lowerS != value)
                {
                    _lowerS = value;
                    OnPropertyChanged(nameof(LowerS));
                }
            }
        }

        private int _lowerV;
        public int LowerV
        {
            get => _lowerV;
            set
            {
                if (_lowerV != value)
                {
                    _lowerV = value;
                    OnPropertyChanged(nameof(LowerV));
                }
            }
        }

        private int _higherH;
        public int HigherH
        {
            get => _higherH;
            set
            {
                if (_higherH != value)
                {
                    _higherH = value;
                    OnPropertyChanged(nameof(HigherH));
                }
            }
        }

        private int _higherS;
        public int HigherS
        {
            get => _higherS;
            set
            {
                if (_higherS != value)
                {
                    _higherS = value;
                    OnPropertyChanged(nameof(HigherS));
                }
            }
        }

        private int _higherV;
        public int HigherV
        {
            get => _higherV;
            set
            {
                if (_higherV != value)
                {
                    _higherV = value;
                    OnPropertyChanged(nameof(HigherV));
                }
            }
        }

        // -------------------------------
        // 新增文件夹相关逻辑
        private string _inputFolder;
        public string InputFolder
        {
            get => _inputFolder;
            set
            {
                if (_inputFolder != value)
                {
                    _inputFolder = value;
                    OnPropertyChanged(nameof(InputFolder));
                }
            }
        }

        private string _outputFolder;
        public string OutputFolder
        {
            get => _outputFolder;
            set
            {
                if (_outputFolder != value)
                {
                    _outputFolder = value;
                    OnPropertyChanged(nameof(OutputFolder));
                }
            }
        }

        public DelegateCommand SelectInputFolderCommand { get; private set; }
        public DelegateCommand SelectOutputFolderCommand { get; private set; }



        public ProcessViewModel(IContainerProvider containerProvider) : base(containerProvider)
        {
            Debug.WriteLine("Here Is the Constructor");
            regionManager = containerProvider.Resolve<IRegionManager>();
            NavigateToPreviewCommand = new DelegateCommand(NavigateToPreview);

            // 其它初始化代码…
            PreviewAnImageCommand = new DelegateCommand(PreviewAnImage);
            // 初始化文件夹选择命令
            SelectInputFolderCommand = new DelegateCommand(SelectInputFolder);
            SelectOutputFolderCommand = new DelegateCommand(SelectOutputFolder);

            // 默认输出文件夹：当前工作目录下的 "Processed_Image"
            string currentDir = Directory.GetCurrentDirectory();
            string processedFolder = Path.Combine(currentDir, "Processed_Image");
            if (!Directory.Exists(processedFolder))
            {
                Directory.CreateDirectory(processedFolder);
            }
            OutputFolder = processedFolder;
        }

        private void NavigateToPreview()
        {
            // 这里假设你的区域名称为 MainRegion，PreviewView 已经在容器中注册了
            regionManager.RequestNavigate("MainViewRegion", "PreviewView", nr =>
            {
                if (!nr.Success)
                {
                    Debug.WriteLine("Navigation to PreviewView failed: " + nr.Exception?.Message);
                }
            });

        }

        public DelegateCommand PreviewAnImageCommand { get; private set; }
        private async void PreviewAnImage()
        {
            await StartPythonCVAsync();

            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "Image Files|*.jpg;*.jpeg;*.png;*.bmp;*.gif;*.tiff"
            };
            if (openFileDialog.ShowDialog() == true)
            {
                string selectedFile = openFileDialog.FileName;
                string ext = Path.GetExtension(selectedFile)?.ToLowerInvariant();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" ||
                    ext == ".bmp" || ext == ".gif" || ext == ".tiff")
                {
                    _selectedImagePath = selectedFile;
                    await RunPreviewPythonScript();
                }
                else
                {
                    MessageBox.Show("请选择有效的图像文件。", "文件错误", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }
        }
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }



        public async Task StartPythonCVAsync()
        {
            if (_pythonCVProcess != null && !_pythonCVProcess.HasExited)
                return;

            try
            {
                string pythonExe = @"C:\Users\Jeff\anaconda3\python.exe";
                string baseDir = AppDomain.CurrentDomain.BaseDirectory;
                string serverScript = Path.Combine(baseDir, "PythonScripts", "preview_server.py");

                var psi = new ProcessStartInfo
                {
                    FileName = pythonExe,
                    Arguments = $"\"{serverScript}\"",
                    UseShellExecute = false,
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    CreateNoWindow = true
                };
                _pythonCVProcess = Process.Start(psi);

                // 异步读取输出以便调试
                _ = Task.Run(() =>
                {
                    string output = _pythonCVProcess.StandardOutput.ReadToEnd();
                    Debug.WriteLine($"[Python Server Output]: {output}");
                });
                _ = Task.Run(() =>
                {
                    string error = _pythonCVProcess.StandardError.ReadToEnd();
                    Debug.WriteLine($"[Python Server Error]: {error}");
                });

                await Task.Delay(1000); // 等待服务端启动
            }
            catch (Exception ex)
            {
                MessageBox.Show($"启动 Python 服务端脚本失败：{ex.Message}");
            }
        }
        private async Task RunPreviewPythonScript()
        {
            try
            {
                // 指定 Python 可执行程序路径
                string pythonExe = @"C:\Users\Jeff\anaconda3\python.exe";
                // 构造 preview.py 的完整路径
                string baseDir = AppDomain.CurrentDomain.BaseDirectory;
                string previewScript = Path.Combine(baseDir, "PythonScripts", "preview.py");

                // 注意：此处必须传递 --image 参数，后面跟用户选择的图片路径
                var psi = new ProcessStartInfo
                {
                    FileName = pythonExe,
                    Arguments = $"\"{previewScript}\" --image \"{_selectedImagePath}\"",
                    UseShellExecute = false,
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    CreateNoWindow = true
                };

                using (var process = Process.Start(psi))
                {
                    // 异步读取标准输出和错误输出（便于调试）
                    string output = await process.StandardOutput.ReadToEndAsync();
                    string error = await process.StandardError.ReadToEndAsync();

                    Debug.WriteLine($"[Preview Script Output]: {output}");
                    Debug.WriteLine($"[Preview Script Error]: {error}");

                    // 等待脚本执行结束
                    await process.WaitForExitAsync();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"启动预览脚本失败: {ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        // --------------------------------------
        private void SelectInputFolder()
        {
            var folderDialog = new CommonOpenFileDialog
            {
                IsFolderPicker = true,
                Title = "Select Input Folder"
            };

            if (folderDialog.ShowDialog() == CommonFileDialogResult.Ok &&
                !string.IsNullOrWhiteSpace(folderDialog.FileName))
            {
                InputFolder = folderDialog.FileName;
            }
        }

        private void SelectOutputFolder()
        {
            // 默认输出目录仍为当前工作目录下的 "Processed_Image"
            string currentDir = Directory.GetCurrentDirectory();
            string defaultFolder = Path.Combine(currentDir, "Processed_Image");
            if (!Directory.Exists(defaultFolder))
            {
                Directory.CreateDirectory(defaultFolder);
            }

            var folderDialog = new CommonOpenFileDialog
            {
                IsFolderPicker = true,
                Title = "Select Output Folder"
            };

            if (folderDialog.ShowDialog() == CommonFileDialogResult.Ok &&
                !string.IsNullOrWhiteSpace(folderDialog.FileName))
            {
                OutputFolder = folderDialog.FileName;
            }
            else
            {
                OutputFolder = defaultFolder;
            }
        }

        public override void OnNavigatedFrom(NavigationContext navigationContext)
        {
            base.OnNavigatedFrom(navigationContext);
        }

        public override void OnNavigatedTo(NavigationContext navigationContext)
        {
            // InitializeTimer();
            Debug.WriteLine("Already Initialized Timer in OnMatigatedTo");
            try
            {
                base.OnNavigatedTo(navigationContext);
            }
            catch (Exception ex) { Debug.WriteLine(ex); }
        }

    }
}
