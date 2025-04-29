using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyToDo1.ViewModels
{
    internal class SystemSettingsViewModel : BindableBase
    {
        private string imageSource;
        public string ImageSource
        {
            get { return imageSource; }
            set { imageSource = value; RaisePropertyChanged(); }
        }
        private string userEmail;
        public string UserEmail
        {
            get { return userEmail; }
            set { userEmail = value; RaisePropertyChanged(); }
        }
        private string userPassword;
        public string UserPassword
        {
            get { return userPassword; }
            set { userPassword = value; RaisePropertyChanged(); }
        }
        private bool passwordVisiability;
        public bool PasswordVisiability
        {
            get { return passwordVisiability; }
            set { passwordVisiability = value; RaisePropertyChanged(); }
        }

        public DelegateCommand ViewPasswordCommand;

        public SystemSettingsViewModel()
        {
            PasswordVisiability = false;
            LoadImage();
            LoadEmail();
            LoadPassword();
            ViewPasswordCommand = new DelegateCommand(ViewPassword);
        }

        private void LoadImage()
        {
            // 获取当前exe文件所在目录
            string exeDirectory = AppDomain.CurrentDomain.BaseDirectory;

            // 构建相对路径指向Image文件夹
            string imagePath = exeDirectory + "Images\\UserImages\\" + "W-Logo_Purple_RGB.png";

            ImageSource = imagePath;
        }

        private void LoadEmail()
        {
            UserEmail = "wdeng4@uw.edu";
        }

        private void LoadPassword()
        {
            UserPassword = "12345678";
        }

        private void ViewPassword()
        {
            passwordVisiability = true;
        }
    }
}
