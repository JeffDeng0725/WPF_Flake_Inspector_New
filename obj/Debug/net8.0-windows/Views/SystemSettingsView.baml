   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:MyToDo1.ExtentionsMyToDo1.Extentions  5	      =#clr-namespace:MyToDo1.Common.ModelsMyToDo1.Common.Models  5      7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels  5      -clr-namespace:MyToDo1.ViewsMyToDo1.Views  5      &     MyToDo1.Views.SystemSettingsView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5      ] YPrism.DryIoc.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59V	 RPrism.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59&prismhttp://prismlibrary.com/  	 5      _
 [Microsoft.Xaml.Behaviors, Version=1.1.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a3i+http://schemas.microsoft.com/xaml/behaviors 
 5      *ext clr-namespace:MyToDo1.Extentions 
 5	      0models#clr-namespace:MyToDo1.Common.Models 
 5      1
viewmodels clr-namespace:MyToDo1.ViewModels 
 5      'localclr-namespace:MyToDo1.Views 
 5      ! 	 Prism.Mvvm.ViewModelLocator    AutoWireViewModel  True5
      .��5      � $
��30,0q�6    � RowDefinitions 5   
   �� 5      $
��auto �6   �� 5      .+�5   
   �� $��System Settings��6   $��24(�6+   $��Bottom=�69   $
��Bold"�6T   $
��0,10q�6f   �� 5   
   ���#dddddd$��0,0,0,1q�6'   � 5   
   $��1��6    5      �� 5      $
��auto �6    �� 5      $
��auto �6    �� 5      $
��auto �6    �� 5       .+�5#      ]� $��false��6   $��20q�6.   .+�5$      � $
��Left=�6   .+�5%      �� $��50��6;   $��50��6G   ��6   �� *ImageSource+6G   �� 5&      $	��100��6   $	��100��6)   ���#FFFFFF J� Opacity$	 0.1Q�6K    �� CornerRadius$ 50��6Y   5'      �� 5(      $
��Jeff��6   $��20q�6&   $��Center=�62    �� 
IsReadOnly$
 True��6O    J� IsHitTestVisible$ False��6a   $|�False��6z   $
��Left=�6�   $��28(�6�   �� 5)         MaterialDesignToolButton#��[  5.       � ToolTip$ Change My Username��5/      +  %MaterialDesignThemes.Wpf.RippleAssist   Feedback 5*      ��  �� RelativeSource �� *Self+	 �� Path$	 
Foreground�  BrushRoundConverter
 �� 	Converter#
 [ ��5+      �� *HomeCommand+��5,      0  *MaterialDesignThemes.Wpf.PackIconExtension     Kind$	 Pen=�   Size 24��5-      ��  ��  �� AncestorType" �$	 (TextElement.Foreground)�5/      50      �� 52       �� Orientation$ 
Horizontal=�6   $��20q�62   $��1��6>   .+�53      �� $��Email: ��6   $��28(�6+   �� 54      $��28(�67   ��6   �� *	UserEmail+67   �� 55      #��[  5:      $ Change My Username��5;       56      ��  �� *Self+$	 
Foreground�#
 [ ��57      �� *HomeCommand+��58        $	 Pen=� 24��59      ��  �� " �$	 (TextElement.Foreground)�5;      5<      �� 5=      $ 
Horizontal=�6   $��20q�62   $��2��6>   .+�5>      �� $��
Password: ��6   $��28(�6.   �� 5?      $��28(�6:   ��6   �� *UserPassword+y�6H   �� *PasswordVisiability+�� 5@      #��[  5E      $ Change My Username��5F       5A      ��  �� *Self+$	 
Foreground�#
 [ ��5B      �� *ViewPasswordCommand+��5C        $	 Eye=� 24��5D      ��  �� " �$	 (TextElement.Foreground)�5F      �� 5H      #��[  5M      $ Change My Username��5N       5I      ��  �� *Self+$	 
Foreground�#
 [ ��5J      �� *HomeCommand+��5K        $	 Pen=� 24��5L      ��  �� " �$	 (TextElement.Foreground)�5N      5O      �� 5Q      $��Log Out My Account��6   
������  MaterialDesignPaperButton#��[ 6O   $��3��6�   5R      5T      5U      