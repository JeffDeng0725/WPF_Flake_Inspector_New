﻿using MyToDo1.Common.Models;
using MyToDo1.Extentions;
using MyToDo1.Views;
using Prism.Navigation.Regions;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Forms;

namespace MyToDo1.ViewModels
{
    public class ToDoViewModel : NavigationViewModel
    {
        private string _title;
        private string _content;
        private string _dtoPath;
        string folderPath;
        public ToDoViewModel(IContainerProvider provider) : base(provider)
        {
            ToDoDtos = new ObservableCollection<ToDoDto>();
            ShowedToDoDtos = new ObservableCollection<ToDoDto>();
            //CreateToDoList();
            // AddCommand = new DelegateCommand(Add);
            NavigateCommand = new DelegateCommand<ToDoDto>(Navigate);
            DeleteAllCommand = new DelegateCommand(DeleteAll);
            EnterCommand = new DelegateCommand(Enter);
            regionManager = provider.Resolve<IRegionManager>();
        }

        private void Enter()
        {
            HandleUserInput();
        }

        private void DeleteAll()
        {
            if (Directory.Exists(folderPath))
            {
                // 获取所有子文件夹的路径
                var directories = Directory.GetDirectories(folderPath);

                // 遍历并删除每个子文件夹
                foreach (var directory in directories)
                {
                    try
                    {
                        // 删除文件夹及其内容
                        Directory.Delete(directory, true); // true 表示递归删除文件夹中的所有内容
                        Console.WriteLine($"Deleted folder: {directory}");
                    }
                    catch (Exception ex)
                    {
                        // 处理删除时的异常
                        Debug.WriteLine($"Failed to delete folder: {directory}. Error: {ex.Message}");
                    }
                }
            }
            else
            {
                System.Windows.MessageBox.Show("The specified directory does not exist.", "Directory Error", MessageBoxButton.OK, MessageBoxImage.Warning);

            }
            CreateToDoList();
        }

        private IRegionManager regionManager;

        private void Navigate(ToDoDto obj)
        {
            if (string.IsNullOrWhiteSpace(obj.Target)) return;

            currentDto = obj;

            NavigationParameters param = new NavigationParameters();
            param.Add("Material", obj.Title);
            param.Add("Time", obj.Content);
            param.Add("InputFolder", obj.DtoPath);

            regionManager.Regions[PrismManager.MainViewRegionName].RequestNavigate(obj.Target,param);
        }

        private bool isRightDrawerOpen;
        public bool IsRightDrawerOpen
        {
            get { return isRightDrawerOpen; }
            set { isRightDrawerOpen = value; RaisePropertyChanged(); }
        }
        //private void Add()
        //{
        //    IsRightDrawerOpen = true;
        //}
        
        private ObservableCollection<ToDoDto> toDoDtos;
        public ObservableCollection<ToDoDto> ToDoDtos
        {
            get { return toDoDtos; }
            set { toDoDtos = value; RaisePropertyChanged(); }
        }

        private ObservableCollection<ToDoDto> showedToDoDtos;
        public ObservableCollection<ToDoDto> ShowedToDoDtos
        {
            get { return showedToDoDtos; }
            set { showedToDoDtos = value; RaisePropertyChanged(); }
        }


        private ToDoDto currentDto;
        public ToDoDto CurrentDto
        {
            get { return currentDto; }
            set { currentDto = value; RaisePropertyChanged(); }
        }
        private string _lookupText;

        public string LookUpText
        {
            get => _lookupText;
            set
            {
                _lookupText = value;
                OnPropertyChanged(nameof(LookUpText)); // 通知绑定属性已更改

                HandleUserInput();
            }
        }
        // INotifyPropertyChanged 实现，确保属性更改时通知 UI 更新
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        // public DelegateCommand AddCommand { get; private set; }
        public DelegateCommand<ToDoDto> NavigateCommand { get; private set; }
        public DelegateCommand DeleteAllCommand { get; private set; }
        public DelegateCommand EnterCommand { get; private set; }

        public void CreateToDoList()
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
            ShowedToDoDtos.Clear();
            if (Directory.Exists(folderPath))
            {
                var directories = new DirectoryInfo(folderPath)
                    .GetDirectories()
                    .OrderByDescending(d => d.CreationTime) // 按文件夹的创建时间排序
                    .ToList();


                foreach (var dir in directories)
                {
                    var folderName = dir.Name; // 获取文件夹名称
                    var newToDo = new ToDoDto()
                    {
                        Title = GetMaterialName(folderName),
                        Content = folderName.Substring(GetMaterialName(folderName).Length + 1),
                        Target = "DetailView",
                        DtoPath = folderName
                    };

                    // 判断是否已经存在具有相同属性的 ToDoDto
                    if (!ToDoDtos.Any(dto =>
                        dto.Title == newToDo.Title &&
                        dto.Content == newToDo.Content &&
                        dto.Target == newToDo.Target))
                    {
                        ToDoDtos.Add(newToDo); // 只有在不存在相同对象时才添加
                        ShowedToDoDtos.Add(newToDo);
                    }
                }
            }
            else
            {
                // 处理路径不存在的情况
                Console.WriteLine("目录不存在");
            }
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

        public override void OnNavigatedTo(NavigationContext navigationContext)
        {
            base.OnNavigatedTo(navigationContext);

            CreateToDoList();
            
        }
        private void HandleUserInput()
        {
            ShowedToDoDtos.Clear(); // 每次输入变化时清空列表

            if (string.IsNullOrEmpty(LookUpText))
            {
                // 如果输入为空，则显示所有的待办事项
                foreach (var item in ToDoDtos)
                {
                    ShowedToDoDtos.Add(item);
                }
            }
            else
            {
                // 筛选出符合条件的 ToDoDto
                foreach (var item in ToDoDtos)
                {
                    if ((item.Title != null && item.Title.Contains(LookUpText, StringComparison.OrdinalIgnoreCase)) ||
                        (item.Content != null && item.Content.Contains(LookUpText, StringComparison.OrdinalIgnoreCase)) ||
                        (item.Target != null && item.Target.Contains(LookUpText, StringComparison.OrdinalIgnoreCase)))
                    {
                        ShowedToDoDtos.Add(item);
                    }
                }
            }
        }
    }
}
