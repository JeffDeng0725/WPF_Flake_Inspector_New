   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:MyToDo1.ViewsMyToDo1.Views  5      7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels  5          MyToDo1.Views.ToDoView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962a:md1http://materialdesigninxaml.net/winfx/xaml/themes  5      :d2http://schemas.microsoft.com/expression/blend/2008  5      'localclr-namespace:MyToDo1.Views  5      1
viewmodels clr-namespace:MyToDo1.ViewModels  5      $��Segoe UI)�5      .��5      )  #MaterialDesignThemes.Wpf.DialogHost  .��5   
   )  #MaterialDesignThemes.Wpf.DrawerHost      IsRightDrawerOpen  6   �� *IsRightDrawerOpen+   RightDrawerContent 5      ]� 5      $	��300��6   $��False��6(   .+�5      �� $��添加待办��6    $��20(�6,   $
��Bold"�6:   $	��Top=�6L   $��15q�6a   �� 5       �� Orientation$ 
Horizontal=�6!   $	��Top=�6:   $��15q�6O   .+�5      �� $��	状态：��6$   $��0,5,15,0q�6/   $
��Left=�6A   �� 5      $
��Left=�6#   $��10��6>   .@�5      �� .��6+   待办6/   �� 5      .��6+   	已完成60   5      5      �� 5      )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ 请输入待办概要��6   $	��Top=�6;   $��15q�6P   �� 5      $ 请输入待办内容��6   $	��Top=�6;   $��15q�6P   �� 5      $��添加到待办��6   $	��Top=�6-   $��15q�6B   5!      .��5$      �  � RowDefinitions 5%      �� 5&      $
��Auto �6$   �� 5'      .+�5*      �� $ 
Horizontal=�6   .+�5+      �� $ 
Horizontal=�6!   $
��Left=�6:   $��Bottom=�6U   .+�5,      �� $��My Scans��6$   $��30(�64   $��20,20q�6B   $��Bottom=�6Q   $��	UltraBold"�6l   �� 5-      -   5        $��LookUpTextBox��5.      $	��250��5/      $��Bottom=�50      $ Looking For a Scan?��51      .  (MaterialDesignThemes.Wpf.TextFieldAssist   HasClearButton$
 True��52      $��10,20q�53      ��54      �� *
LookUpText+ �� UpdateSourceTrigger$ PropertyChanged=��� 56      $
��Left=�6!   $��Enter��6<   $��Bottom=�57   >   $��	10,0,0,20q�58         MaterialDesignPaperButton#��[  60    �� 	IsDefault$
 True��6c   ��57      �� *EnterCommand+58   c   �� 59      $��Filter:��5:      $��
10,0,20,20q�5;      $��Bottom=�5<      $��20(�5=      �� 5>       �� SelectedIndex$ 0��6#   $��Bottom=�65   $��	0,0,10,20q�6P   .@�5?      �� .��6+   hBN60   �� 5@      .��6+   
Graphene65   �� 5A      .��6+   MoTe262   5B      5E      �� 5G      $ 
Horizontal=�6!   $��Right=�6:   .+�5H      �� $��Right=�6!   $��
Delete All��6=   $��Bottom=�6w   $��	10,0,0,20q�6�   #��[  6�   ��6R   �� *DeleteAllCommand+6�   5I      5J      �� 5L      ���#dddddd$��0,0,0,1q�6/   �� 5N      $
��Auto=�6   $��1��6B   .��5O      �� $��1��6#   ��60   �� *ShowedToDoDtos+��5P      �� 5Q      .R�5R   "   � 5S      ��5V      �� 5W      .R�5X   "   � $	��220��6'   $	��180��63   $	��250��6C   $��15q�6S   	 J� InputBindings	 5Z   &   d� 5[   *   
 d� MouseAction$
 	LeftClicke�67    �� Command 5\   7   �� *DataContext.NavigateCommand+ �� RelativeSource ��  �� Mode$ FindAncestor=� �� AncestorType ItemsControl �� CommandParameter 5]   7   ��  5_   &   �� 5`   *   $
��auto �68   �� 5a   *   .+�5d   &   ��  �� CornerRadius$ 10��6-   $��2��6?   ���#b7a57a$��Stretch=�6e   ��5e   *   �� 5f   .    �� 
TargetType" ��64    �� Triggers 5g   2   P� 5h   6    P� Property �@J�IsMouseOver P� Value$
 True��6U   . �5i   :   ��  �� Property �@J�Effect �� Value 5j   >   3  -System.Windows.Media.Effects.DropShadowEffect  5k   B      Color$ #DDDDDD��5l   E      ShadowDepth$ 1Q�5m   E      
BlurRadius$ 10Q�5n   E   5p   ;   �� 5q   :    �@�Cursor$
 Hand��6S   5r   7   5t   /   ._�5v   *   �  5w   .   �� 5x   2   $
��auto �6@   �� 5y   2   .+�5{   .   �� $��2��65   $
}�True��6F   .+�5|   2   �� 
 �� Top$ 10��5}   	    �� Right$	 -50��6   $	��120��5~   	   $	��120��6   ���#FFFFFF J� Opacity$	 0.1Q�5�   	   $	 100��5�   	   �� 5�   2   $ 80��5�   	   $	 -30��6   $	��120��5�   	   $	��120��6   ���#FFFFFF$	 0.1Q�5�   	   $	 100��5�   	   5�   /   �� 5�   .   $��materialTitle��68   $
��Left=�6d   $��
25,20,0, 0q�6   $
��Bold"�6�   $��30(�6�   ��6M   �� *Title+6�   �� 5�   .   $��timeContent��68   $��1��6d   $
��Left=�6q   $��25,15q�6�   $��16(�6�   ��6K   �� *	Content+6�   5�   +   5�   '   5�   #   5�      5�      5�      5�      5�      5�      5�      