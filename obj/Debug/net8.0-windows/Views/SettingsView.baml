   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:MyToDo1.ExtentionsMyToDo1.Extentions  5      -clr-namespace:MyToDo1.ViewsMyToDo1.Views  5
           MyToDo1.Views.SettingsView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5      _ [Microsoft.Xaml.Behaviors, Version=1.1.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a3i+http://schemas.microsoft.com/xaml/behaviors  5      :d2http://schemas.microsoft.com/expression/blend/2008  5      *ext clr-namespace:MyToDo1.Extentions  5      ]	 YPrism.DryIoc.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59V
 RPrism.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59&prismhttp://prismlibrary.com/ 	 
 5	      )localclr-namespace:MyToDo1.Views 	 
 5
      $��Segoe UI)�5      .��5      �   � RowDefinitions  5   
   �� 5      $
��auto �6   �� 5      .+�5   
   �� $��Settings��6   $��30(�6$   $��20,20q�62   $��Bottom=�6A   $��	UltraBold"�6\   �� 5   
   ���#dddddd$��0,0,0,1q�6'   � 5   
   $��1��6    � ColumnDefinitions 5      �� 5      $	��200 �6#   �� 5      .+�5      �� -   5         ��Name$ menuBar��5      ��6'   �� *
MenuBars+*  $Microsoft.Xaml.Behaviors.Interaction   Triggers 5       +  %Microsoft.Xaml.Behaviors.EventTrigger  5!         	EventName$ SelectionChanged��6%   *  $Microsoft.Xaml.Behaviors.TriggerBase   Actions. 5"      2  ,Microsoft.Xaml.Behaviors.InvokeCommandAction     Command 60   �� *NavigateCommand+   CommandParameter 6T   ��  �� ElementName$ menuBar��	 �� Path$	 SelectedItem�5#      ��5%      �� 5&      .R�5'      �� 
 �� Orientation$
 
Horizontal=�6%   
������ $��5q�6W   .+�5(      '  !MaterialDesignThemes.Wpf.PackIcon  $
��15,0q�6L      Kind 66   �� *Icon+6L   �� 5)      $
��10,0q�6(   ��66   �� *Title+5*      5,      5.      �� 50      $��1��6   %   MyToDo1.Extentions.PrismManager   SettingsViewRegionName, 
 &Prism.Navigation.Regions.RegionManager   
RegionName# Z 6-   $��
20,0,20,35q�6�   52      53      54      