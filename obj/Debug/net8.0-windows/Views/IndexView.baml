   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:MyToDo1.ViewsMyToDo1.Views  5      7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels  5   W       MyToDo1.Views.IndexView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      -localclr-namespace:MyToDo1.Views     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5      1
viewmodels clr-namespace:MyToDo1.ViewModels  6W   $��Segoe UI)�5
      .��5      �   � RowDefinitions  5   
   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      .+�5   
   ��  �� Orientation$ 
Horizontal=�6   $��0��6/   .+�5      �� $��Index��6   $��30(�6%   $��20q�63   $��Bottom=�6?   $��	UltraBold"�6Z   �� 5      -   5        $��DateTextBlock��5      $��20(�6-   $
��0,20q�6;   $��Bottom=�6I   5      �� 5   
   ���#dddddd$��0,0,0,1q�6'   �� 5   
   $��1��6   $��0,15,0,0q�6E   ��6$   �� *
TaskBars+��5      �� 5      .R�5      A�  A� Columns$ 4��6"   5      ��5       �� 5!      .R�5"      �� $
��15,0q�6:    �� CornerRadius$ 10��6H   ��6   �� *Color+��5#      �� 5$       �� 
TargetType" ��6$    �� Triggers 5%   "   P� 5&   &    P� Property �@J�IsMouseOver P� Value$
 True��6E   . �5'   *   ��  �� Property �@J�Effect	 �� Value	 5(   .   3  -System.Windows.Media.Effects.DropShadowEffect  5)   2   
   Color$
 #DDDDDD��5*   5      ShadowDepth$ 1Q�5+   5      
BlurRadius$ 10Q�5,   5   5.   +   50   '   52      ._�54      � .+�55      �� $��20,20q�6)   $
��Left=�68   .+�56   "   '  !MaterialDesignThemes.Wpf.PackIcon  $��30��58   %   $��30��59   %      Kind 57   %   �� *Icon+59   %   �� 5;   "   $
��0,15q�5=   %   $��24(�5>   %   $
��Bold"�5?   %   ��5<   %   �� *Title+5?   %   �� 5A   "   $
��Bold"�5C   %   $��40(�5D   %   ��5B   %   �� *	Content+5D   %   5F      �� 5H      $
}�True��6%   .+�5I   "   �� 
 �� Top$ 10��6)    �� Right$	 -50��69   $	��120��5J   )   $	��120��65   ���#FFFFFF J� Opacity$	 0.1Q�5L   )   $	 100��5M   )   �� 5N   "   $ 80��6)   $	 -30��69   $	��120��5O   )   $	��120��65   ���#FFFFFF$	 0.1Q�5Q   )   $	 100��5R   )   5S      5T      5U      5V      5X      � 5Z   
   $��2��6   $
��0,15q�6    � ColumnDefinitions 5[      �� 5\      �� 5]      .+�5`      �� $��0��5a      $
��15,0q�5b      $ 10��5c      $	 0.1Q�5d      ���#BEBEBE5e      �� 5g      $��1��5h      $
��15,0q�5i      $ 10��5j      $	 0.1Q�5k      ���#BEBEBE5l      ]� 5n      $
��15,0q�6   .+�5o      ]� $��15,15q�5p      $	��Top=�5q      $��False��5r      .+�5s      �� $��My Scans��6    $��24(�5t       $
��Bold"�5u       �� 5v      $��30��6   $��30��5w      $��Right=�5x      $	��Top=�5y       /  +MaterialDesignFloatingActionSecondaryButton#��[  5z      .��5|        $	 Add=�62   5}      5�      �� 5�      $��Stretch=�5�      ��5�      �� *
ToDoDtos+ J� InputBindings 5�      d� 5�       d� MouseAction$ 	LeftClicke�6'    �� Command 5�      �� *'%DataContext.NavigateDetailViewCommand+ �� RelativeSource ��  �� Mode$ FindAncestor=� �� AncestorType ItemsControl �� CommandParameter 5�      �� ��5�      �� 5�      .R�5�      ]� $��80��6(   $��False��67   $
��10,0q�6M   .+�5�   "   d� $��Right=�6/   �� 5�   "   .+�5�   &   �� $��20(�5�   1   $
��Bold"�5�   1   ��5�   0   �� *Title+5�   1   �� 5�   &   $
��0,10q�5�   1   $	 0.5Q�5�   1   ��5�   0   �� *	Content+5�   1   5�   #   5�      5�      5�      5�      ]� 5�      $
��15,0q�6   $��1��6&   .+�5�      ]� $��15,15q�5�      $	��Top=�5�      $��False��5�      .+�5�      �� $
��Memo��5�      $��24(�5�      $
��Bold"�5�      �� 5�      $��30��5�      $��30��5�      $��Right=�5�      $	��Top=�5�      #��[  5�      .��5�        $	 Add=�62   5�      5�      �� 5�      ��6   �� *
MemoDtos+��5�      �� 5�      .R�5�      �� $��80��6)   $
��10,0q�68   .+�5�   "   �� $��20(�5�      $
��Bold"�5�      ��5�   ,   �� *Title+5�      �� 5�   "   $
��0,10q�5�      $	 0.5Q�5�      ��5�   ,   �� *	Content+5�      5�      5�      5�      5�      5�      5�      5�      