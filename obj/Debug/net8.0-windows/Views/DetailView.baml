   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:MyToDo1.ExtentionsMyToDo1.Extentions  5	      =#clr-namespace:MyToDo1.Common.ModelsMyToDo1.Common.Models  5
      7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels  5      -clr-namespace:MyToDo1.ViewsMyToDo1.Views  5          MyToDo1.Views.DetailView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5      ] YPrism.DryIoc.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59V	 RPrism.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59&prismhttp://prismlibrary.com/  	 5      _
 [Microsoft.Xaml.Behaviors, Version=1.1.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a3i+http://schemas.microsoft.com/xaml/behaviors 
 5      *ext clr-namespace:MyToDo1.Extentions 
 5	      0models#clr-namespace:MyToDo1.Common.Models 
 5
      1
viewmodels clr-namespace:MyToDo1.ViewModels 
 5      'localclr-namespace:MyToDo1.Views 
 5      ! 	 Prism.Mvvm.ViewModelLocator    AutoWireViewModel  True5      $��Segoe UI)�5      .��5      � .+�5   
   )  #MaterialDesignThemes.Wpf.DialogHost     
Identifier$ ImagePreviewDialogHost��6$      IsOpen 6H   �� *
ShowDialog+.��5      �  � RowDefinitions 5      �� 5      $
��auto �6$   �� 5      .+�5      �� $��Details��6   $��26(�6+   $��20,20q�69   $��Bottom=�6H   $
��Bold"�6c   �� 5      ���#dddddd$��0,0,0,1q�6/   � 5      $��1��6    � ColumnDefinitions 5       �� 5!      $
��Auto �6+   �� 5"      .+�5%      �  5&      �� 5'      $
��auto �6,   �� 5(      .+�5+      �� $��Images: ��6$   $��25,20, 20,0q�64   $
��Left=�6I   $��Center=�6d   $��22(�6   $
��Bold"�6�   �� 5,      -   5         ��Name$ 	detailBar��5,   "   $��10q�6}   $��1��6�   $
��Auto��6�   ��65   �� *
DetailBars+* 
 $Microsoft.Xaml.Behaviors.Interaction   Triggers 5-      + 
 %Microsoft.Xaml.Behaviors.EventTrigger  5.   "      	EventName$ SelectionChanged��61   * 
 $Microsoft.Xaml.Behaviors.TriggerBase   Actions. 5/   &   2 
 ,Microsoft.Xaml.Behaviors.InvokeCommandAction  	   Command	 6<   �� *ViewCommand+
   CommandParameter
 6\   ��  �� ElementName$ 	detailBar�� �� Path$ SelectedItem�50   #   ��52      �� 53   "   .R�54   &   �� $
��10,5q�60   ��6>   �� *Title+��55   *   �� 56   .    �� 
TargetType" ��64   .�57   2   ��  �� Property � �� �� Value
 ���� 6O    �� Triggers 59   2   P� 5:   6    P� Property �@J�IsMouseOver P� Value$
 True��6U   . �5;   :   ��  �@�Cursor$
 Hand��6S   5<   7   5>   /   5@   '   5B   #   5D      5E      � 5H      $��1��6    5I      �� 5J      $
��Auto �6,   �� 5K      .+�5N      ��  �� Orientation$ 
Horizontal=�6%   $��10q�6>   .+�5O      �� $��Show Filtered Result Only��6(   $��20,20,10,20q�6J   $��Center=�6_   $��Center=�6z   $��16(�6�   d� 5P      -   5        $��Filter��5P   +    d� 	IsChecked 69   �� *
IsFilterOn+ �� Mode$ TwoWay=�5Q      �� 5U      $
��Auto=�6'   $��1��6J   $��0,0,1,0q�6W   .��5V      �� $ Vertical=�6)   $��1��6@   $
��Left=�6M   $��10,20q�6h   $	��Top=�6w   .+�5W   "   �� $ 
Horizontal=�6-   .+�5_   &   �� $ 
Horizontal=�61   .+�5`   *   �� $��Like This Image? ��64   $��20,20,10,20q�6M   $��Center=�6b   $��Center=�6}   $��16(�6�   d� 5a   *    )  %MaterialDesignFlatPrimaryToggleButton#��[  6�    � ToolTip$+ %MaterialDesignFlatPrimaryToggleButton��6�   ��67   0  *MaterialDesignThemes.Wpf.PackIconExtension     Kind$ Heart=�   Size 21 6n   �� *IsLikedPara+��6�   �� *LikeCommand+5c   '   5d   #   �� 5g   "   $ 
Horizontal=�6-   .+�5i   &   �� $ Vertical=�61   .+�5j   *   �� $��Flakes:��64   $
��20,0q�6C   �� 5m   *   $	��700��6T   $
��Auto��6`   $
��Left=�6n   $��Stretch=�6�   $��Uniform=�6�   $��
20,5,20,20q�6�    � Cursor$
 Hand��6�   ��60   �� *ContourImagePath+ J� InputBindings 5n   .   d� 5o   2    d� Gesture$ 	LeftClicka�6?    �� Command 6S   �� *ImageClickCommand+5q   +   5r   '   5|   #   5�      5�      5�      5�      5�         DialogContent 5�      �� 5�      ._�5�      �� $
��auto��6!   $
��auto��6.   $��20q�6<   .+�5�      ]� -   5        $��DragDockPanel��5�   :   $��False��6$   .+�5�      �� $��Image Preview��6(   $
��Bold"�6=   $��16(�6O   $��10q�6]   �� 5�      -   5         ��Name$ btnClose��5�   %    ! MaterialDesignFlatMidBgButton#��[ 67      CloseDialogCommand#��Z 6n   $��Right=�6�   .��5�   "   '  !MaterialDesignThemes.Wpf.PackIcon      Kind$  Close=�6:   $��20��6G   $��20��6R   5�      5�      (� 5�      .��5�      �� $
��1200��6H   $	��900��6U   $��Uniform=�6b   $��10q�6t   ��6$   �� *ContourImagePath+6t   5�      �� 5�      $��Close��6!   #��Z 61   $��10q�6s   5�      5�      5�      5�      5�      