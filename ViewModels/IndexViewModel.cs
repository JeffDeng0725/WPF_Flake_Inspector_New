using MyToDo1.Common.Models;
using MyToDo1.Extentions;
using Prism.Navigation.Regions;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyToDo1.ViewModels
{
    internal class IndexViewModel : NavigationViewModel
    {
        public DelegateCommand<ToDoDto> NavigateDetailViewCommand { get; private set; }
        private IRegionManager regionManager;
        public IndexViewModel(IContainerProvider provider) : base(provider)
        {
            TaskBars = new ObservableCollection<TaskBar>();
            ToDoDtos = new ObservableCollection<ToDoDto>();
            MemoDtos = new ObservableCollection<MemoDto>();
            NavigateDetailViewCommand = new DelegateCommand<ToDoDto>(NavigateDetailView);
            //updateFolderPath();
            //UpdateViewedNumber();
            //UpdateLikedPercent();
            //UpdateMemoNumber();
            //TaskBars.Clear();
            //CreateTaskBars();
            //CreateTestData();

        }

        public void NavigateDetailView(ToDoDto obj)
        {
            if (string.IsNullOrWhiteSpace(obj.Target)) return;

            NavigationParameters param = new NavigationParameters();
            param.Add("Material", obj.Title);
            param.Add("Time", obj.Content);

            regionManager.Regions[PrismManager.MainViewRegionName].RequestNavigate(obj.Target, param);
        }

        //----------------------
        private ObservableCollection<TaskBar> taskBars;
        public ObservableCollection<TaskBar> TaskBars
        {
            get { return taskBars; }
            set { taskBars = value; RaisePropertyChanged(); }
        }
        //----------------------
        private ObservableCollection<ToDoDto> toDoDtos;
        public ObservableCollection<ToDoDto> ToDoDtos
        {
            get { return toDoDtos; }
            set { toDoDtos = value; OnPropertyChanged(nameof(ToDoDtos)); }
        }
        //-----------------------
        private ObservableCollection<MemoDto> memoDtos;
        public ObservableCollection<MemoDto> MemoDtos
        {
            get { return memoDtos; }
            set { memoDtos = value; RaisePropertyChanged(); }
        }
        private int totalNumber;
        private int viewedNumber;
        private string likedPercent;
        private int memoNumnber;
        private string folderPath;

        private void updateFolderPath()
        {
            string exeDirectory = AppDomain.CurrentDomain.BaseDirectory; // 获取当前 exe 文件所在的目录
            string processedImageFolderPath = Path.Combine(exeDirectory, "Processed_Image"); // 构建指向 "Processed_Image" 文件夹的路径

            // 如果文件夹不存在则创建
            if (!Directory.Exists(processedImageFolderPath))
            {
                Directory.CreateDirectory(processedImageFolderPath);
            }
            folderPath = processedImageFolderPath;
        }
        private void UpdateTotalNumber()
        {
            updateFolderPath();
            try
            {
                // 获取 folderPath 下所有子文件夹的路径
                string[] directories = Directory.GetDirectories(folderPath);
                totalNumber = directories.Length;
            }
            catch (DirectoryNotFoundException ex)
            {
                Console.WriteLine("The specified folder path does not exist.");
            }
            catch (UnauthorizedAccessException ex)
            {
                Console.WriteLine("You do not have permission to access this folder.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
            }
        }
        private void UpdateViewedNumber()
        {
            updateFolderPath();
            viewedNumber = totalNumber;
        }
        private void UpdateLikedPercent()
        {
            likedPercent = (double)100.0*(viewedNumber) / (totalNumber) + "%";    
        }
        private void UpdateMemoNumber()
        {
            memoNumnber = MemoDtos.Count;
        }

        void CreateTaskBars()
        {
            TaskBars.Add(new TaskBar() { Icon = "ClockFast", Title = "Total", Content = totalNumber.ToString(), Color = "#b7a57a", Target = "" });
            TaskBars.Add(new TaskBar() { Icon = "ClockCheckOutLine", Title = "Viewed", Content = viewedNumber.ToString(), Color = "#4b2e83", Target = "" });
            TaskBars.Add(new TaskBar() { Icon = "ChartLineVarient", Title = "Liked", Content = likedPercent, Color = "#85754d", Target = "" });
            TaskBars.Add(new TaskBar() { Icon = "PlaylistStar", Title = "Memo", Content = memoNumnber.ToString(), Color = "#c5b4e3", Target = "" });

        }

        void CreateTestData()
        {
            CreateToDoList();

            CreateMemoList();
        }

        private void CreateToDoList()
        {
            // 获取当前的 outputDirTextBox.Text 中的路径
            //string currentDirectory = Directory.GetCurrentDirectory();
            //string processedImageFolderPath = System.IO.Path.Combine(currentDirectory, "Processed_Image");
            string exeDirectory = AppDomain.CurrentDomain.BaseDirectory; // 获取当前 exe 文件所在的目录
            string processedImageFolderPath = Path.Combine(exeDirectory, "Processed_Image"); // 构建指向 "Processed_Image" 文件夹的路径

            // 如果文件夹不存在则创建
            if (!Directory.Exists(processedImageFolderPath))
            {
                Directory.CreateDirectory(processedImageFolderPath);
            }
            folderPath = processedImageFolderPath;

            ToDoDtos.Clear();
            if (Directory.Exists(folderPath))
            {
                var directories = new DirectoryInfo(folderPath)
                    .GetDirectories()
                    .OrderByDescending(d => d.CreationTime) // 按文件夹的创建时间排序
                    .ToList();

                totalNumber = directories.Count;
                foreach (var dir in directories)
                {
                    var folderName = dir.Name; // 获取文件夹名称
                    var newToDo = new ToDoDto()
                    {
                        Title = GetMaterialName(folderName),
                        Content = folderName.Substring(GetMaterialName(folderName).Length + 1),
                        Target = "DetailView"
                    };

                    // 判断是否已经存在具有相同属性的 ToDoDto
                    if (!ToDoDtos.Any(dto =>
                        dto.Title == newToDo.Title &&
                        dto.Content == newToDo.Content &&
                        dto.Target == newToDo.Target))
                    {
                        ToDoDtos.Add(newToDo); // 只有在不存在相同对象时才添加
                    }
                }
            }
            else
            {
                // 处理路径不存在的情况
                Debug.WriteLine("目录不存在");
            }
        }
        void CreateMemoList()
        {
            MemoDtos.Clear();

            // 获取当前exe文件所在的文件夹路径
            string exeFolder = AppDomain.CurrentDomain.BaseDirectory;

            // 构建Memos文件夹路径
            string memosFolderPath = Path.Combine(exeFolder, "Memos");

            // 检查Memos文件夹是否存在
            if (!Directory.Exists(memosFolderPath))
            {
                Console.WriteLine("Memos文件夹不存在");
                return;
            }

            // 获取Memos文件夹中的所有txt文件，并按创建时间倒序排序
            string[] txtFiles = Directory.GetFiles(memosFolderPath, "*.txt")
                .OrderByDescending(f => File.GetCreationTime(f)) // 按创建时间倒序排序
                .ToArray();

            // 遍历每个txt文件，按创建时间倒序处理
            foreach (string filePath in txtFiles)
            {
                string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(filePath);
                string fileContent = File.ReadAllText(filePath);

                // 默认 Status = false
                bool status = false;

                // 检查文件名的后缀
                if (fileNameWithoutExtension.EndsWith("_False"))
                {
                    // 去掉"_False"
                    fileNameWithoutExtension = fileNameWithoutExtension.Substring(0, fileNameWithoutExtension.Length - "_False".Length);
                    status = false;
                }
                else if (fileNameWithoutExtension.EndsWith("_True"))
                {
                    // 去掉"_True"
                    fileNameWithoutExtension = fileNameWithoutExtension.Substring(0, fileNameWithoutExtension.Length - "_True".Length);
                    status = true;
                }

                // 添加到 MemoDtos 和 ShowedMemoDtos 列表
                MemoDtos.Add(new MemoDto { Title = fileNameWithoutExtension, Content = fileContent, Status = status });
            }
        }

        public override void OnNavigatedFrom(NavigationContext navigationContext)
        {
            base.OnNavigatedFrom(navigationContext);
        }

        public override void OnNavigatedTo(NavigationContext navigationContext)
        {
            base.OnNavigatedTo(navigationContext);
            updateFolderPath();
            UpdateTotalNumber();
            UpdateViewedNumber();
            UpdateLikedPercent();
            CreateTestData();
            UpdateMemoNumber();
            TaskBars.Clear();
            CreateTaskBars();
            

        }

        public string GetMaterialName(string folderName)
        {
            string material = "";
            foreach (char c in folderName)
            {
                if (c == '-')
                {
                    break;
                }
                material += c;
            }
            return material;
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
