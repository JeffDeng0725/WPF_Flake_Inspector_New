   M S B A M L   `   `   `  ����[  WMaterialDesignColors, Version=3.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aY@clr-namespace:MaterialDesignColors;assembly=MaterialDesignColorsMaterialDesignColors  5      B >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:MyToDo1.Common.ConvertersMyToDo1.Common.Converters 5      -clr-namespace:MyToDo1.ViewsMyToDo1.Views 5	      7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels 68      MyToDo1.Views.SkinView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5      [materialDesignColors@clr-namespace:MaterialDesignColors;assembly=MaterialDesignColors  5      8
converters'clr-namespace:MyToDo1.Common.Converters  5      'localclr-namespace:MyToDo1.Views  5	      1
viewmodels clr-namespace:MyToDo1.ViewModels  68   $��Segoe UI)�5        � 	Resources  5      5  /MyToDo1.Common.Converters.ColorToBrushConverter   ColorToBrushConverter  SwatchColorTemplate �� DataType �� 	Converter �� RelativeSource �� AncestorType��%   &	        &	      7     5   
   6+   �� 5   
   " ��63   .R�5      �� $��40��6   $��40��5      $��1q�5      $��0q�5      ��5      �� 8   ��5      �� *DataContext.ChangeHueCommand+ ��  local:SkinView��5      �� 5      5      5      .��5      � $
��30,0q�6    � RowDefinitions 5   
   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      .+�5"   
   �� $��Color��6   $��24(�6!   $��Bottom=�6/   $
��Bold"�6J   $
��0,10q�6\   �� 5$   
   ���#dddddd$��0,0,0,1q�6'   �� 5&   
    �� Orientation$ 
Horizontal=�6   $��Center=�6.   $��	0,15,0,15q�6I   $��1��6\   .+�5'      �� $��Light��6   $��Center=�6%   d� 5(      $��8,0,16,0q�6   $��Center=�6O    � Cursor$
 Hand��6j    d� 	IsChecked 6-   �� *IsDarkTheme+6j   �� 5)      $
��Dark��6   $��Center=�6$   5*      �� 5,   
   $
��Auto=�6   $��2��6:   $��5,0,5,0q�6G   .��5-      �� ��6   �� *
Swatches+��5.      �� 5/      "   MaterialDesignColors.ISwatch"  6#   .R�50      �� $ 
Horizontal=�6%   .+�51      �� $	��100��6(   $��Center=�52      $��0,0,10,0q�54   (   ��53      �� *Name+	 �� Mode$	 OneTime=�54   (   �� 55      #��[ 6+   ��56      �� *Lookup.Values+$	 OneTime=���57   "   �� 58   &   .R�59   *   $� 
 $� Orientation$
 
Horizontal=�6A   5:   '   5<      5=      5>      5@      5A      5C      5D      