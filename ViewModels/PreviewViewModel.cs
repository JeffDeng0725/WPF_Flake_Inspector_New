using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media.Imaging;
using System.Windows.Media;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Net.Sockets;
using System.Net;
using System.Text.Json;
using Prism.Commands;
using System.Windows.Threading;

namespace MyToDo1.ViewModels
{
    internal class PreviewViewModel : NavigationViewModel
    {
        // 用于显示用户选择的原始图像（预览）
        private ImageSource _currentImage;
        public ImageSource CurrentImage
        {
            get => _currentImage;
            set
            {
                _currentImage = value;
                OnPropertyChanged(nameof(CurrentImage));
            }
        }

        // 用于显示处理后的图像（ResultImage）
        private ImageSource _resultImage;
        public ImageSource ResultImage
        {
            get => _resultImage;
            set
            {
                _resultImage = value;
                Debug.WriteLine("ResultImage updated: " + (_resultImage != null));
                OnPropertyChanged(nameof(ResultImage));
            }
        }

        /// <summary>
        /// 通过指定路径加载图像，更新 CurrentImage（用于初步预览）
        /// </summary>
        public void LoadNewImage(string path)
        {
            try
            {
                CurrentImage = new BitmapImage(new Uri(path, UriKind.RelativeOrAbsolute));
            }
            catch (Exception ex)
            {
                Debug.WriteLine("加载图像错误：" + ex.Message);
            }
        }

        // HSV 参数绑定属性
        private double _lowerH;
        public double LowerH
        {
            get => _lowerH;
            set
            {
                _lowerH = value;
                OnPropertyChanged(nameof(LowerH));
                ResetUpdateTimer();
            }
        }
        private double _lowerS;
        public double LowerS
        {
            get => _lowerS;
            set
            {
                _lowerS = value;
                OnPropertyChanged(nameof(LowerS));
                ResetUpdateTimer();
            }
        }
        private double _lowerV;
        public double LowerV
        {
            get => _lowerV;
            set
            {
                _lowerV = value;
                OnPropertyChanged(nameof(LowerV));
                ResetUpdateTimer();
            }
        }
        private double _higherH;
        public double HigherH
        {
            get => _higherH;
            set
            {
                _higherH = value;
                OnPropertyChanged(nameof(HigherH));
                ResetUpdateTimer();
            }
        }
        private double _higherS;
        public double HigherS
        {
            get => _higherS;
            set
            {
                _higherS = value;
                OnPropertyChanged(nameof(HigherS));
                ResetUpdateTimer();
            }
        }
        private double _higherV;
        public double HigherV
        {
            get => _higherV;
            set
            {
                _higherV = value;
                OnPropertyChanged(nameof(HigherV));
                ResetUpdateTimer();
            }
        }

   

        // 保存用户选中的图片绝对路径
        private string _selectedImagePath;

        // 保存启动的 Python 服务端进程引用
        private Process _pythonServerProcess;

        /// <summary>
        /// 启动 Python 服务端脚本，确保它开始监听 127.0.0.1:9999
        /// </summary>
        public async Task StartPythonServerAsync()
        {
            if (_pythonServerProcess != null && !_pythonServerProcess.HasExited)
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
                _pythonServerProcess = Process.Start(psi);

                // 异步读取输出以便调试
                _ = Task.Run(() =>
                {
                    string output = _pythonServerProcess.StandardOutput.ReadToEnd();
                    Debug.WriteLine($"[Python Server Output]: {output}");
                });
                _ = Task.Run(() =>
                {
                    string error = _pythonServerProcess.StandardError.ReadToEnd();
                    Debug.WriteLine($"[Python Server Error]: {error}");
                });

                await Task.Delay(2000); // 等待服务端启动
            }
            catch (Exception ex)
            {
                MessageBox.Show($"启动 Python 服务端脚本失败：{ex.Message}");
            }
        }

        /// <summary>
        /// 上传图像命令，调用 OpenFileDialog 选择图片
        /// </summary>
        public ICommand UploadPreviewImageCommand { get; }

        public PreviewViewModel(IContainerProvider provider) : base(provider)
        {
            UploadPreviewImageCommand = new DelegateCommand(UploadPreviewImage);
            // 初始化 HSV 参数默认值
            LowerH = 0;
            LowerS = 0;
            LowerV = 0;
            HigherH = 180;
            HigherS = 255;
            HigherV = 255;
            ShutDoownCommand = new DelegateCommand(ShutDoown);
            //InitializeTimer();


            _updateTimer.Interval = TimeSpan.FromMilliseconds(500);
            _updateTimer.Tick += UpdateTimer_Tick;
            Debug.WriteLine("Already Initialized Timer in Constructor");

        }

        //private void InitializeTimer()
        //{
        //    // 初始化定时器
        //    _updateTimer = new DispatcherTimer();
        //    _updateTimer.Interval = TimeSpan.FromMilliseconds(500);
        //    _updateTimer.Tick += UpdateTimer_Tick;
        //    ResetUpdateTimer();
        //}

        /// <summary>
        /// 使用 OpenFileDialog 选择图片，保存路径、预览原图，
        /// 同时启动 Socket 通信调用 Python 服务端处理图像，
        /// 并接收一幅 Result 图像数据更新 ResultImage。
        /// </summary>
        private async void UploadPreviewImage()
        {
            await StartPythonServerAsync();

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
                    LoadNewImage(selectedFile);
                    await RunSocketClientAsync();
                }
                else
                {
                    MessageBox.Show("请选择有效的图像文件。", "文件错误", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }
        }

        /// <summary>
        /// 通过 Socket 将 HSV 参数和图片路径发送给 Python 服务端，
        /// 并接收一幅图像数据更新 ResultImage。
        /// </summary>
        public async Task RunSocketClientAsync()
        {
            try
            {
                using (TcpClient client = new TcpClient())
                {
                    await client.ConnectAsync("127.0.0.1", 9999);
                    using (NetworkStream stream = client.GetStream())
                    {
                        // 构造 JSON 参数
                        var parameters = new
                        {
                            lowerH = (int)LowerH,
                            lowerS = (int)LowerS,
                            lowerV = (int)LowerV,
                            higherH = (int)HigherH,
                            higherS = (int)HigherS,
                            higherV = (int)HigherV,
                            input_image_path = _selectedImagePath,
                            output_dir = "Processed"
                        };

                        string json = JsonSerializer.Serialize(parameters) + "\n";
                        byte[] jsonBytes = Encoding.UTF8.GetBytes(json);
                        await stream.WriteAsync(jsonBytes, 0, jsonBytes.Length);
                        Debug.WriteLine("Client sent: " + json);

                        // 读取第一幅图像数据（ResultImage）
                        byte[] lengthBuffer = new byte[4];
                        int totalRead = 0;
                        while (totalRead < 4)
                        {
                            int r = await stream.ReadAsync(lengthBuffer, totalRead, 4 - totalRead);
                            if (r == 0) break;
                            totalRead += r;
                        }
                        if (totalRead != 4)
                        {
                            MessageBox.Show("未能读取到图像数据长度。");
                            return;
                        }
                        int dataLength = IPAddress.NetworkToHostOrder(BitConverter.ToInt32(lengthBuffer, 0));
                        byte[] imageBuffer = new byte[dataLength];
                        totalRead = 0;
                        while (totalRead < dataLength)
                        {
                            int r = await stream.ReadAsync(imageBuffer, totalRead, dataLength - totalRead);
                            if (r == 0) break;
                            totalRead += r;
                        }

                        Debug.WriteLine($"Expecting {dataLength} bytes, actually read {totalRead} bytes");


                        // 将接收到的图像数据转换为 BitmapImage 并更新 ResultImage
                        await Application.Current.Dispatcher.InvokeAsync(() =>
                        {
                            try
                            {
                                BitmapDecoder decoder;
                                using (var ms = new MemoryStream(imageBuffer))
                                {
                                    decoder = BitmapDecoder.Create(ms,
                                        BitmapCreateOptions.PreservePixelFormat,
                                        BitmapCacheOption.OnLoad);
                                }
                                var frame = decoder.Frames[0];
                                frame.Freeze();
                                ResultImage = frame;
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("转换图像失败：" + ex.ToString());
                            }
                        });

                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Socket client error: {ex.Message}");
            }
        }

        // INotifyPropertyChanged 实现，确保属性更改时通知 UI 更新
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        /// <summary>
        /// 关闭 Python 服务端进程（例如在应用退出时调用）
        /// </summary>
        public void ShutdownPythonServer()
        {
            if (_pythonServerProcess != null && !_pythonServerProcess.HasExited)
            {
                try
                {
                    _pythonServerProcess.Kill();
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"关闭服务器进程出错：{ex.Message}");
                }
                finally
                {
                    _pythonServerProcess = null;
                }
            }
        }
        
        public DelegateCommand ShutDoownCommand { get; private set; }
        private void ShutDoown()
        {
            ShutdownPythonServer();
            Debug.Write("Shuted Down!");
        }

        private DispatcherTimer _updateTimer = new DispatcherTimer();

        private async void UpdateTimer_Tick(object sender, EventArgs e)
        {
            _updateTimer.Stop(); // 停止定时器，防止重复触发
                                 // 确保已经选择了图片
            if (!string.IsNullOrEmpty(_selectedImagePath))
            {
                await RunSocketClientAsync();
            }
        }

        private void ResetUpdateTimer()
        {
            _updateTimer.Stop();
            _updateTimer.Start();
        }



    }
}
