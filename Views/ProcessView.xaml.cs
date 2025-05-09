using MaterialDesignThemes.Wpf;
using Microsoft.WindowsAPICodePack.Dialogs;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace MyToDo1.Views
{
    /// <summary>
    /// ProcessView.xaml 的交互逻辑
    /// </summary>
    public partial class ProcessView : UserControl
    {
        public ProcessView()
        {
            InitializeComponent();
        }

        private void folderPathTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}
