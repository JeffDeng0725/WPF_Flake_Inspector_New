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
using System.Security.RightsManagement;
using System.Collections.ObjectModel;
using System.Runtime.CompilerServices;

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

        private string _inputFolder;
        public string InputFolder
        {
            get => _inputFolder;
            set => SetProperty(ref _inputFolder, value);
            // SetProperty: 如果值变了，会自动帮你触发基类的 PropertyChanged
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

        private int _minArea;
        public int MinArea
        {
            get => _minArea;
            set
            {
                _minArea = value;
                OnPropertyChanged(nameof(MinArea));
            }
        }

        private int _minPerimeter;
        public int MinPerimeter
        {
            get => _minPerimeter;
            set
            {
                _minPerimeter = value;
                OnPropertyChanged(nameof(MinPerimeter));
            }
        }

        private int _maxPerimeter;
        public int MaxPerimeter
        {
            get => _maxPerimeter;
            set
            {
                _maxPerimeter = value;
                OnPropertyChanged(nameof(MaxPerimeter));
            }
        }

        private int _maxArea;

        private double _maximumRoughness;
        public double MaximumRoughness
        {
            get => _maximumRoughness;
            set
            {
                _maximumRoughness = value;
                OnPropertyChanged(nameof(MaximumRoughness));
            }
        }

        private double _minimumCircularity;
        public double MinimumCircularity
        {
            get => _minimumCircularity;
            set
            {
                _minimumCircularity = value;
                OnPropertyChanged(nameof(MinimumCircularity));
            }
        }

        private int __reference;
        public int Reference
        {
            get => __reference;
            set
            {
                __reference = value;
                OnPropertyChanged(nameof(Reference));
            }
        }

        private String _setterName;
        public String SetterName
        {
            get => _setterName;
            set
            {
                _setterName = value;
                OnPropertyChanged(nameof(SetterName));
            }
        }

        public ObservableCollection<string> Materials { get; }
        = new ObservableCollection<string>
            {
                "Graphene",
                "hBN",
                "MoSe2",
                "MoTe2",
                "WSe2",
                "WTe2"
            };

        private string _selectedMaterial;
        public string SelectedMaterial
        {
            get => _selectedMaterial;
            set => SetProperty(ref _selectedMaterial, value);
        }

        private bool _isProcessing;
        public bool IsProcessing
        {
            get => _isProcessing;
            set => SetProperty(ref _isProcessing, value);
        }

        public DelegateCommand SelectInputFolderCommand { get; private set; }
        public DelegateCommand SelectOutputFolderCommand { get; private set; }
        public DelegateCommand RunFlakeDetectionAsyncCommand { get; private set; }



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
            RunFlakeDetectionAsyncCommand = new DelegateCommand(
            async () =>
            {
                IsProcessing = true;
                try
                {
                    await RunFlakeDetectionAsync();
                }
                finally
                {
                    IsProcessing = false;
                }
            });

            // 默认输出文件夹：当前工作目录下的 "Processed_Image"
            string currentDir = Directory.GetCurrentDirectory();
            string processedFolder = Path.Combine(currentDir, "Processed_Image");
            if (!Directory.Exists(processedFolder))
            {
                Directory.CreateDirectory(processedFolder);
            }
            OutputFolder = processedFolder;

            _minArea = 2000;
            _minPerimeter = 100;
            _maxPerimeter = 5000;
            _lowerH = 124;
            _lowerS = 17;
            _lowerV = 113;
            _higherH = 143;
            _higherS = 119;
            _higherV = 255;
            _maximumRoughness = 0.23;
            _minimumCircularity = 0.2;
            __reference = 150;
            SelectedMaterial = Materials.FirstOrDefault();

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
                // 这样会调用 InputFolder.set 并触发 PropertyChanged
                InputFolder = folderDialog.FileName;
                Debug.WriteLine("InputFolder: " + InputFolder);
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

        public async Task RunFlakeDetectionAsync()
        {
            // 1) Locate your python interpreter and script
            var pythonExe = "python"; // or full path to python.exe
            var baseDir = AppDomain.CurrentDomain.BaseDirectory;
            var scriptPath = Path.Combine(baseDir, "PythonScripts", "ImageProcess3_HSV.py");
            if (!File.Exists(scriptPath))
                throw new FileNotFoundException("Cannot find ImageProcess3_HSV.py", scriptPath);

            // 2) Build the argument string
            var args = new[]
            {
        $"\"{scriptPath}\"",
        $"--input_folder \"{InputFolder}\"",
        $"--output_folder \"{OutputFolder}\"",
        $"--setter_name \"{SetterName}\"",
        $"--lower_h {LowerH}",
        $"--lower_s {LowerS}",
        $"--lower_v {LowerV}",
        $"--higher_h {HigherH}",
        $"--higher_s {HigherS}",
        $"--higher_v {HigherV}",
        $"--min_area {MinArea}",
        $"--min_perimeter {MinPerimeter}",
        $"--max_perimeter {MaxPerimeter}",
        $"--max_roughness {MaximumRoughness.ToString(System.Globalization.CultureInfo.InvariantCulture)}",
        $"--min_circularity {MinimumCircularity.ToString(System.Globalization.CultureInfo.InvariantCulture)}",
        $"--reference {Reference}"
    };
            var startInfo = new ProcessStartInfo
            {
                FileName = pythonExe,
                Arguments = string.Join(" ", args),
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                CreateNoWindow = true
            };

            // 3) Start the process and hook output
            using var proc = new Process { StartInfo = startInfo };
            proc.OutputDataReceived += (s, e) => { if (e.Data != null) Debug.WriteLine("[py] " + e.Data); };
            proc.ErrorDataReceived += (s, e) => { if (e.Data != null) Debug.WriteLine("[py-err] " + e.Data); };

            proc.Start();
            proc.BeginOutputReadLine();
            proc.BeginErrorReadLine();

            // 4) Await exit
            await proc.WaitForExitAsync();

            if (proc.ExitCode != 0)
            {
                throw new Exception($"flake_detector.py exited with code {proc.ExitCode}");
            }
        }

    }
}
