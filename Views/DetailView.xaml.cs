using MyToDo1.Common.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MyToDo1.ViewModels;

namespace MyToDo1.Views
{
    /// <summary>
    /// DetailView.xaml 的交互逻辑
    /// </summary>
    public partial class DetailView : UserControl
    {
        private bool isDragging = false;
        private Point lastMousePosition;
        public DetailView()
        {
            InitializeComponent();

        }
        private void Dialog_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                isDragging = true;
                lastMousePosition = e.GetPosition(this.Parent as UIElement); // 相对于父容器的鼠标位置
                ((Border)sender).CaptureMouse(); // 捕获鼠标事件，跟踪拖动
            }
        }

        // 当用户移动鼠标时，更新对话框的位置
        private void Dialog_MouseMove(object sender, MouseEventArgs e)
        {
            if (isDragging)
            {
                var currentMousePosition = e.GetPosition(this.Parent as UIElement);
                var diff = currentMousePosition - lastMousePosition;

                // 获取对话框的当前渲染变换
                var dialogTransform = ((UIElement)sender).RenderTransform as TranslateTransform;
                if (dialogTransform == null)
                {
                    dialogTransform = new TranslateTransform();
                    ((UIElement)sender).RenderTransform = dialogTransform;
                }

                // 更新对话框的位置
                dialogTransform.X += diff.X;
                dialogTransform.Y += diff.Y;

                // 更新最后的鼠标位置
                lastMousePosition = currentMousePosition;
            }
        }

        // 当用户释放鼠标左键时，结束拖动
        private void Dialog_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (isDragging)
            {
                isDragging = false;
                ((Border)sender).ReleaseMouseCapture(); // 释放鼠标捕获
            }
        }

    }
}
