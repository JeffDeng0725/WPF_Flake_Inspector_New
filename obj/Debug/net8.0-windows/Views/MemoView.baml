   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels  5      -clr-namespace:MyToDo1.ViewsMyToDo1.Views  5	          MyToDo1.Views.MemoView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962a:md1http://materialdesigninxaml.net/winfx/xaml/themes  5      1
viewmodels clr-namespace:MyToDo1.ViewModels  5      'localclr-namespace:MyToDo1.Views  5	      $��Segoe UI)�5      .��5      )  #MaterialDesignThemes.Wpf.DialogHost  .��5   
   )  #MaterialDesignThemes.Wpf.DrawerHost      IsRightDrawerOpen  6   �� *IsRightDrawerOpen+   RightDrawerContent 5      ]� 5      $	��300��6   $��False��6(   .+�5      �� $��
Add a Memo��6    $��20(�62   $
��Bold"�6@   $	��Top=�6R   $��15q�6g   �� 5       �� Orientation$ 
Horizontal=�6!   $	��Top=�6:   $��15q�6O   .+�5      �� $��	Status：��6$   $��0,5,15,0q�63   $
��Left=�6E   �� 5      $
��Left=�6#   $��10��6>    �� SelectedIndex 6L   �� *UserStatusComboBoxSelection+ �� UpdateSourceTrigger$ PropertyChanged=�.@�5      �� .��6+   
Unfinished67   �� 5      .��6+   
Finished65   5      5      �� 5      )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Summary of the memo��6   $	��Top=�6G   $��15q�6\   ��6h   �� *SummaryText+$ PropertyChanged=��� 5      $ Content��6   $	��Top=�6;   $��15q�6P   ��6\   �� *ContentText+$ PropertyChanged=��� 5       $��Add to My Memo��6   $	��Top=�66   $��15q�6K   ��6W   �� *ReallyAddCommand+5"      .��5%      �  � RowDefinitions 5&      �� 5'      $
��Auto �6$   �� 5(      .+�5+      �� $ 
Horizontal=�6   .+�5,      �� $ 
Horizontal=�6!   $
��Left=�6:   $��Bottom=�6U   .+�5-      �� $
��Memo��6$   $��30(�60   $��20,20q�6>   $��Bottom=�6M   $��	UltraBold"�6h   �� 5.      -   5        $��LookUpTextBox��5/      $	��250��50      $��Bottom=�51      $ Looking for Something?��52      .  (MaterialDesignThemes.Wpf.TextFieldAssist   HasClearButton$
 True��53      $��10,20q�54      ��55      �� *
LookUpText+$ PropertyChanged=��� 57      $
��Left=�6!   $��Enter��6<   $��Bottom=�58   >   $��	10,0,0,20q�59         MaterialDesignPaperButton#��[  60    �� 	IsDefault$
 True��6c   ��58      �� *EnterCommand+59   c   �� 5:      $��Filter:��5;      $��
10,0,20,20q�5<      $��Bottom=�5=      $��20(�5>      �� 5?      $ 0��6#   $��Bottom=�65   $��	0,0,10,20q�6P   .@�5@      �� .��6+   hBN60   �� 5A      .��6+   
Graphene65   �� 5B      .��6+   MoTe262   5C      �� 5E      $
��Left=�6!   $��
Add a Memo��6<   $��Bottom=�5F   4   $��	10,0,0,20q�5G      #��[  5H      ��5F      �� *
AddCommand+5H      5I      �� 5K      $ 
Horizontal=�6!   $��Right=�6:   .+�5L      �� $��Right=�6!   $��
Delete All��6=   $��Bottom=�6w   $��	10,0,0,20q�6�   #��[  6�   ��6R   �� *DeleteAllCommand+6�   5M      5N      �� 5P      ���#dddddd$��0,0,0,1q�6/   �� 5R      $
��Auto=�6   $��1��6B   .��5S      �� $��1��6#   ��60   �� *ShowedMemoDtos+��5T      �� 5U      .R�5V   "   � 5W      ��5Z      �� 5[      .R�5\   "   � $
��auto��6'   $	��180��64   $	��250��6D   $��15q�6T   	 J� InputBindings	 5^   &   d� 5_   *   
 d� MouseAction$
 	LeftClicke�67    �� Command 5`   /   �� *DataContext.NavigateCommand+ �� RelativeSource ��  �� Mode$ FindAncestor=� �� AncestorType ItemsControl �� CommandParameter 5a   /   ��  5c   &   �� 5d   *   $
��auto �68   �� 5e   *   .+�5h   &   ��  �� CornerRadius$ 10��6-   $��2��6?   ���#b7a57a$��Stretch=�6e   ��5i   *   �� 5j   .    �� 
TargetType" ��64    �� Triggers 5k   2   P� 5l   6    P� Property �@J�IsMouseOver P� Value$
 True��6U   . �5m   :   ��  �� Property �@J�Effect �� Value 5n   >   3  -System.Windows.Media.Effects.DropShadowEffect  5o   B      Color$ #DDDDDD��5p   =      ShadowDepth$ 1Q�5q   =      
BlurRadius$ 10Q�5r   =   5t   ;   �� 5u   :    �@�Cursor$
 Hand��6S   5v   7   5x   /   ._�5z   *   �  5{   .   �� 5|   2   $
��auto �6@   �� 5}   2   .+�5   .   �� $��2��65   $
}�True��6F   .+�5�   2   �� 
 �� Top$ 10��5�       �� Right$	 -50��6   $	��120��5�      $	��120��6   ���#FFFFFF J� Opacity$	 0.1Q�5�      $	 100��5�      �� 5�   2   $ 80��5�      $	 -30��6   $	��120��5�      $	��120��6   ���#FFFFFF$	 0.1Q�5�      $	 100��5�      5�   /   �� 5�   .   $��materialTitle��68   $
��Left=�6d   $��25,20,40, 0q�6   $
��Bold"�6�   $��30(�6�   ��6M   �� *Title+6�   �� 5�   .   $��timeContent��68   $��1��6d   $
��Left=�6q   $��25,15q�6�   $��16(�6�   ��6K   �� *	Content+6�   5�   +   5�   '   5�   #   5�      5�      5�      5�      5�      5�      5�      