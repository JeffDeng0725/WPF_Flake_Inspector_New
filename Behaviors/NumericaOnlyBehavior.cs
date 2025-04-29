using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Windows;
using System.Windows.Controls;

namespace MyToDo1.Behaviors
{
    public static class NumericOnlyBehavior
    {
        public static readonly DependencyProperty IsNumericProperty =
            DependencyProperty.RegisterAttached(
                "IsNumeric",
                typeof(bool),
                typeof(NumericOnlyBehavior),
                new PropertyMetadata(false, OnIsNumericChanged));

        public static bool GetIsNumeric(DependencyObject obj)
        {
            return (bool)obj.GetValue(IsNumericProperty);
        }

        public static void SetIsNumeric(DependencyObject obj, bool value)
        {
            obj.SetValue(IsNumericProperty, value);
        }

        private static void OnIsNumericChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is TextBox textBox)
            {
                bool isNumeric = (bool)e.NewValue;
                if (isNumeric)
                {
                    textBox.PreviewTextInput += TextBox_PreviewTextInput;
                    DataObject.AddPastingHandler(textBox, OnPaste);
                }
                else
                {
                    textBox.PreviewTextInput -= TextBox_PreviewTextInput;
                    DataObject.RemovePastingHandler(textBox, OnPaste);
                }
            }
        }

        private static void TextBox_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            // 只有当输入的文本能够转换为整数时才允许输入
            e.Handled = !IsTextNumeric(e.Text);
        }

        private static bool IsTextNumeric(string text)
        {
            return int.TryParse(text, out _);
        }

        private static void OnPaste(object sender, DataObjectPastingEventArgs e)
        {
            if (e.DataObject.GetDataPresent(typeof(string)))
            {
                string text = (string)e.DataObject.GetData(typeof(string));
                if (!IsTextNumeric(text))
                {
                    e.CancelCommand();
                }
            }
            else
            {
                e.CancelCommand();
            }
        }
    }
}
