using Prism.Commands;
using Prism.Mvvm;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyToDo1.ViewModels
{
    public class ImagePreviewDialogViewModel : BindableBase, IDialogAware
    {
        private string _imagePath;
        public string ImagePath
        {
            get { return _imagePath; }
            set { SetProperty(ref _imagePath, value); }
        }

        // 私有字段用于存储事件处理程序
        private event Action<IDialogResult> _requestClose;

        public DelegateCommand CloseCommand { get; private set; }

        DialogCloseListener IDialogAware.RequestClose => throw new NotImplementedException();

        public ImagePreviewDialogViewModel()
        {
            CloseCommand = new DelegateCommand(CloseDialog);
        }

        public bool CanCloseDialog()
        {
            return true;
        }

        public void OnDialogClosed()
        {
        }

        public void OnDialogOpened(IDialogParameters parameters)
        {
            if (parameters.ContainsKey("imagePath"))
            {
                ImagePath = parameters.GetValue<string>("imagePath");
            }
        }

        private void CloseDialog()
        {
            var parameters = new DialogParameters();
            parameters.Add("closed", true);

            var result = new DialogResult
            {
                Result = ButtonResult.OK,
                Parameters = parameters
            };

            // 触发私有事件
            _requestClose?.Invoke(result);
        }

        bool IDialogAware.CanCloseDialog()
        {
            throw new NotImplementedException();
        }

        void IDialogAware.OnDialogClosed()
        {
            throw new NotImplementedException();
        }

        void IDialogAware.OnDialogOpened(IDialogParameters parameters)
        {
            throw new NotImplementedException();
        }
    }


}
