using MyToDo1.Common.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Diagnostics;

namespace MyToDo1.ViewModels
{
    class MemoViewModel : NavigationViewModel
    {
        public MemoDto newMemoDto;
        public DelegateCommand AddCommand { get; private set; }
        public DelegateCommand ReallyAddCommand { get; private set; }
        public MemoViewModel(IContainerProvider provider) : base(provider)
        {
            MemoDtos = new ObservableCollection<MemoDto>();
            ShowedMemoDtos = new ObservableCollection<MemoDto>();
            AddCommand = new DelegateCommand(Add);
            ReallyAddCommand = new DelegateCommand(ReallyAdd);
            CreateMemoList();
        }

        private void ReallyAdd()
        {
            // 获取当前exe文件所在的文件夹路径
            string exeFolder = AppDomain.CurrentDomain.BaseDirectory;

            // 构建Memos文件夹路径
            string memosFolderPath = Path.Combine(exeFolder, "Memos");

            // 如果Memos文件夹不存在，则创建它
            if (!Directory.Exists(memosFolderPath))
            {
                Directory.CreateDirectory(memosFolderPath);
            }

            // 构建txt文件的名称，格式为 Title_Status.txt
            string fileName = $"{newMemoDto.Title}_{newMemoDto.Status}.txt";
            string filePath = Path.Combine(memosFolderPath, fileName);

            // 写入文件内容
            File.WriteAllText(filePath, newMemoDto.Content);

            Debug.WriteLine($"文件已创建: {filePath}");
            CreateMemoList();
            IsRightDrawerOpen = false;
        }

        private void Add()
        {
            IsRightDrawerOpen = true;
            newMemoDto = new MemoDto();
        }

        private bool isRightDrawerOpen;
        public bool IsRightDrawerOpen
        {
            get { return isRightDrawerOpen; }
            set { isRightDrawerOpen = value; RaisePropertyChanged(); }
        }
        private ObservableCollection<MemoDto> memoDtos;
        public ObservableCollection<MemoDto> MemoDtos
        {
            get { return memoDtos; }
            set { memoDtos = value; RaisePropertyChanged(); }
        }

        private ObservableCollection<MemoDto> showedMemoDtos;
        public ObservableCollection<MemoDto> ShowedMemoDtos
        {
            get { return showedMemoDtos; }
            set { showedMemoDtos = value; RaisePropertyChanged(); }
        }
        private MemoDto currentDto;
        public MemoDto CurrentDto
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
        private string userStatusComboBoxSelection;
        public string UserStatusComboBoxSelection
        {
            get { return userStatusComboBoxSelection; }
            set 
            { 
                userStatusComboBoxSelection = value;
                if (userStatusComboBoxSelection.Equals("Unfinished"))
                {
                    newMemoDto.Status = false;
                }
                else if (userStatusComboBoxSelection.Equals("Finished"))
                {
                    newMemoDto.Status = true;
                }
                OnPropertyChanged(nameof(UserStatusComboBoxSelection));
            }
        }
        private string summaryText;
        public string SummaryText
        {
            get { return summaryText; }
            set
            {
                summaryText = value;
                newMemoDto.Title = summaryText;
                OnPropertyChanged(nameof(SummaryText));
            }
        }
        private string contentText;
        public string ContentText
        {
            get { return contentText; }
            set
            {
                contentText = value;
                newMemoDto.Content = contentText;
                OnPropertyChanged(nameof(ContentText));

            }
        }
        // INotifyPropertyChanged 实现，确保属性更改时通知 UI 更新
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }



        private void HandleUserInput()
        {
            ShowedMemoDtos.Clear(); // 每次输入变化时清空列表

            if (string.IsNullOrEmpty(LookUpText))
            {
                // 如果输入为空，则显示所有的待办事项
                foreach (var item in MemoDtos)
                {
                    ShowedMemoDtos.Add(item);
                }
            }
            else
            {
                // 筛选出符合条件的 ToDoDto
                foreach (var item in MemoDtos)
                {
                    if ((item.Title != null && item.Title.Contains(LookUpText, StringComparison.OrdinalIgnoreCase)) ||
                        (item.Content != null && item.Content.Contains(LookUpText, StringComparison.OrdinalIgnoreCase)))
                    {
                        ShowedMemoDtos.Add(item);
                    }
                }
            }
        }

        void CreateMemoList()
        {
            MemoDtos.Clear();
            ShowedMemoDtos.Clear();

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
                ShowedMemoDtos.Add(new MemoDto { Title = fileNameWithoutExtension, Content = fileContent, Status = status });
            }
        }


        public override void OnNavigatedTo(NavigationContext navigationContext)
        {
            base.OnNavigatedTo(navigationContext);
            CreateMemoList();
        }
    }

}
