   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:MyToDo1.ExtentionsMyToDo1.Extentions  5	      =#clr-namespace:MyToDo1.Common.ModelsMyToDo1.Common.Models  5
      7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels  5      -clr-namespace:MyToDo1.ViewsMyToDo1.Views  5      5clr-namespace:MyToDo1.BehaviorsMyToDo1.Behaviors  5          MyToDo1.Views.ProcessView   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5      ] YPrism.DryIoc.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59V	 RPrism.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59&prismhttp://prismlibrary.com/  	 5      _
 [Microsoft.Xaml.Behaviors, Version=1.1.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a3i+http://schemas.microsoft.com/xaml/behaviors 
 5      *ext clr-namespace:MyToDo1.Extentions 
 5	      0models#clr-namespace:MyToDo1.Common.Models 
 5
      1
viewmodels clr-namespace:MyToDo1.ViewModels 
 5      'localclr-namespace:MyToDo1.Views 
 5      /	behaviorsclr-namespace:MyToDo1.Behaviors 
 5      $��Segoe UI)�5        � 	Resources  5         LoadingAnimationStoryboard g� RepeatBehavior �� 
TargetName �� TargetProperty W� From	 W� To g� Duration  	BoolToVis��%�   &	        &	 �     �� 5   
   $ Forever��68   .��5      W� $ arcRotateTransform��5      $ (RotateTransform.Angle)�5       05       3606   $ 0:0:2D�5      5      �� 5   
   6'   5!      .��5#      �  � RowDefinitions 5$   
   �� 5%      $
��auto �6   �� 5&      .+�5(   
   �� $��Process��6   $��30(�6#   $��20,20q�61   $��Bottom=�6@   $��	UltraBold"�6[   �� 5*   
   ���#dddddd$��0,0,0,1q�6'   �� 5,   
   $
��Auto=�6   $��1��6:   .��5-      �  5.      �� 5/      $
��auto �6$   �� 50      $
��auto �6$   �� 51      $
��auto �6$   �� 52      $
��auto �6$   �� 53      .+�57      � $��0��6   $
��0,20q�6$    � ColumnDefinitions 58      �� 59      $
��auto �6+   �� 5:      $
��auto �6+   �� 5;      .+�5>      �� $
��15,0q�5?      	 �� CornerRadius$	 10��5@      
 J� Opacity$	
 0.1Q�5A      ���#BEBEBE$��2��5C      �� 5D      $��2��5E      $
��15,0q�5F      $	 10��5G      $	
 0.1Q�5H      ���#BEBEBE5I      �� 5K      -   5        $��SelectInputSatckPanel��5K   !    �� Orientation$ Vertical=�6>   $
��Left=�6U   $
��20,0q�6p   .+�5L      �� $��Input Folder��6$   $��20(�68   $
��Left=�6F   $��10q�6a   �� 5M      -   5        $��folderPathTextBox��5M   "   $
��Left=�6�   $��10q�6�   ��6;   �� *InputFolder+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�6�   �� 5N      -   5        $��selectFolderPathBtn��5N   !   $��Select Input Folder��6<   $
��Left=�6[   $��10,10,10,20q�6v     MaterialDesignPaperButton#��[ 6�   ��6�   �� *SelectInputFolderCommand+5O      �� 5Q      $ Vertical=�6!   $��1��68   $��Bottom=�6H   $��20q�6c   .+�5S      �� $"��Unsure about the parameters?��6$   $��10q�6H   $
��Left=�6T   �� 5U      $��Preview an Image��6!   #��[ 6f   $��Bottom=�6�   $��10, 0q�6�   $
��Left=�6�   ��6<   �� *PreviewAnImageCommand+6�   5V      �� 5W      $ Vertical=�6!   $
��Left=�68   $
��20,0q�6S   $��2��6a   .+�5X      �� $��Output Folder��6$   $��20(�69   $
��Left=�6G   $��10q�6b   �� 5Y      $ 
Horizontal=�6%   $
��Left=�6>   .+�5Z      �� -   5        $��outputDirTextBox��5Z   &   $
��Left=�6>   $��10q�6Y   ��6e   �� *OutputFolder+�� 5[      $
��Copy��6%   $��Bottom=�64   $
��Left=�6O   $��8(�6j   #��[ 6w   5\      �� 5]      -   5        $��selectOutputDirButton��5]   !   $��Select Output Folder��6>   $
��Left=�6]   $��10,10,10,20q�6x   #��[ 6�   5^      5b      � 5e      $��1��6   $��0,0,0,20q�6$    5f      �� 5g      $
��auto �6+   �� 5h      $
��auto �6+   �� 5i      .+�5k      �� $��0��5l      $
��15,0q�5m      $	 10��5n      $	
 0.1Q�5o      ���#BEBEBE5p      �� 5q      $��1��5r      $
��15,0q�5s      $	 10��5t      $	
 0.1Q�5u      ���#BEBEBE5v      �� 5w      $��2��5x      $
��15,0q�5y      $	 10��5z      $	
 0.1Q�5{      ���#BEBEBE5|      �� 5�      $ Vertical=�6!   $
��Left=�68   $��
30,0,30,10q�6S   .+�5�      �� $��
Lower HSV:��6$   $��16(�66   $��Medium"�6D   $��0, 15q�6X   ]� 5�      $��False��6$   $	��0,5q�6:   .+�5�      �� $��Lower H:��6(   $��16(�68   $��Light"�6F   $��Center=�6Y   �� 5�      -   5         ��Name$ lowerHSlider��5�   %    � Maximum$	 180Q�6;    � Minimum$ 0Q�6I   $	��230��6U   $
��15,0q�6a   $��Center=�5�   \    � Value 6   �� *LowerH+$ TwoWay=�$ PropertyChanged=�6\   �� 5�      $��16(�5�      $��Center=�6"   $
��10,0q�6=   ��5�   (   ��  �� ElementName$ lowerHSlider�� �� Path$ Value� �� StringFormat$ {0:0}��5�   =   5�      ]� 5�      $��False��6$   $	��0,5q�6:   .+�5�      �� $��Lower S:��6(   $��16(�68   $��Light"�6F   $��Center=�6Y   �� 5�      -   5        $ lowerSSlider��5�   %   $	 255Q�6;   $ 0Q�6I   $	��230��6U   $
��15,0q�6a   $��Center=�5�   \    6   �� *LowerS+$ TwoWay=�$ PropertyChanged=�6\   �� 5�      $��16(�5�      $��Center=�6"   $
��10,0q�6=   ��5�   (   �� $ lowerSSlider��$ Value�$ {0:0}��5�   =   5�      ]� 5�      $��False��6$   $	��0,5q�6:   .+�5�      �� $��Lower V:��6(   $��16(�68   $��Light"�6F   $��Center=�6Y   �� 5�      -   5        $ lowerVSlider��5�   %   $	 255Q�6;   $ 0Q�6I   $	��230��6U   $
��15,0q�6a   $��Center=�5�   \    6   �� *LowerV+$ TwoWay=�$ PropertyChanged=�6\   �� 5�      $��16(�5�      $��Center=�6"   $��
10,0,10,10q�6=   ��5�   (   �� $ lowerVSlider��$ Value�$ {0:0}��5�   =   5�      5�      �� 5�      $��1��6!   $ Vertical=�61   $
��Left=�6H   $��
30,0,30,10q�6c   .+�5�      �� $��Higher HSV:��6$   $��16(�67   $��Medium"�6E   $��0, 15q�6Y   ]� 5�      $	��Top=�6$   $��False��69   $	��0,5q�6O   .+�5�      �� $��	Higher H:��6(   $��16(�69   $��Light"�6G   $��Center=�6Z   �� 5�      -	   5        $ higherHSlider��5�   %   $	 180Q�6<   $ 0Q�6J   $	��230��6V   $
��15,0q�6b   $��Center=�5�   ]    6   �� *	HigherH+$ TwoWay=�$ PropertyChanged=�6]   �� 5�      $��16(�5�      $��Center=�6"   $
��10,0q�6=   ��5�   (   �� $ higherHSlider��$ Value�$ {0:0}��5�   =   5�      ]� 5�      $	��Top=�6$   $��False��69   $	��0,5q�6O   .+�5�      �� $��	Higher S:��6(   $��16(�69   $��Light"�6G   $��Center=�6Z   �� 5�      -
   5        $ higherSSlider��5�   %   $	 255Q�6<   $ 0Q�6J   $	��230��6V   $
��15,0q�6b   $��Center=�5�   ]    6   �� *	HigherS+$ TwoWay=�$ PropertyChanged=�6]   �� 5�      $��16(�5�      $��Center=�6"   $
��10,0q�6=   ��5�   (   �� $ higherSSlider��$ Value�$ {0:0}��5�   =   5�      ]� 5�      $	��Top=�6$   $��False��69   $	��0,5q�6O   .+�5�      �� $��	Higher V:��6(   $��16(�69   $��Light"�6G   $��Center=�6Z   �� 5�      -   5        $ higherVSlider��5�   %   $	 255Q�6<   $ 0Q�6J   $	��230��6V   $
��15,0q�6b   $��Center=�5�   ]    6   �� *	HigherV+$ TwoWay=�$ PropertyChanged=�6]   �� 5�      $��16(�5�      $��Center=�6"   $��
10,0,10,10q�6=   ��5�   (   �� $ higherVSlider��$ Value�$ {0:0}��5�   =   5�      5�      �� 5�      $��2��6!   $ Vertical=�61   $
��Left=�6H   $��
30,0,30,10q�6c   .+�5�      �� $'��!Material: (Suggesting Parameters)��6$   $��16(�6M   $��Medium"�6[   $��0, 15q�6o   $
��Left=�6~   �� 5�      $	��120��5�      $
��0,15q�5�      $
��Left=�5�      ��5�      �� *	Materials+ �� SelectedItem 5�      �� *SelectedMaterial+$ TwoWay=�5�      5�      5�      � 5�      $��2��6    5�      �� 5�      $
��auto �6+   �� 5�      $
��auto �6+   �� 5�      .+�5�      �� $��0��5�      $
��15,0q�5�      $	 10��5�      $	
 0.1Q�5�      ���#BEBEBE5�      �� 5�      $��1��5�      $
��15,0q�5�      $	 10��5�      $	
 0.1Q�5�      ���#BEBEBE5�      �� 5�      $��2��5�      $
��15,0q�5�      $	 10��5�      $	
 0.1Q�5�      ���#BEBEBE5�      �� 5�      $ Vertical=�6!   $
��Left=�68   $��
30,0,30,10q�6S   $��0��6g   .+�5      �� $��Sensitive Parameters:��6$   $��16(�6A   $��Medium"�6O   $
��Left=�6c   $
��0,15q�6~   ]� 5     $��False��6$   $	��0,5q�6:   .+�5     �� $��Minumum Area: ��6(   $��16(�6>   $��Light"�6L   $
��Left=�6_   $��Center=�6z   ,  &MaterialDesignThemes.Wpf.NumericUpDown  5     -   5        $��minAreaNumericUD��5  ;      AllowChangeOnScroll$
 True��6S   $
��Left=�5  '   $	��Top=�6B   $	��5,0q�6Z   $��Right=�5  '      Value 6>   �� *	MinArea+$ TwoWay=�5     ]� 5	     $��False��6$   $	��0,5q�6:   .+�5
     �� $��Minumum Perimeter: ��6(   $��16(�6C   $��Light"�6Q   $
��Left=�6d   $��Center=�6     5     -   5        $��minPerimeterNumericUD��5  ;   $
 True��6X   $	��5,0q�6s   $��Right=�5  '    6>   �� *MinPerimeter+$ TwoWay=�5     ]� 5     $��False��6$   $	��0,5q�6:   .+�5     �� $��Maxiumum Perimeter: ��6(   $��16(�6D   $��Light"�6R   $
��Left=�6e   $��Center=�6�     5     -   5        $��maxPerimeterNumericUD��5  ;   $
 True��6X   $
��Left=�5  '   $	��Top=�6B   $	��5,0q�6Z   $��Right=�5  '    6>   �� *MaxPerimeter+$ TwoWay=�5     5     �� 5     $��
30,0,30,10q�6!   $ Vertical=�65   $
��Left=�6L   $��1��6g   .+�5     �� $��Sensitive Parameters:��6$   $��16(�6A   $��Medium"�6O   $
��Left=�6c   $
��0,15q�6~   ]� 5     $	��Top=�6$   $��False��69   $	��0,5q�6O   .+�5     �� $��Maximum Roughness:��6(   $��16(�6B   $��Light"�6P   $��Center=�6c   �� 5     $ 
Horizontal=�6)   $��Right=�6B   $��Right=�6^   .+�5  "   �� -   5        $ maxRoughnessSlider��5  )   $ 1Q�6E   $ 0Q�6Q   $	��230��6]   $
��15,0q�6i   $��Center=�5   f    6   �� *MaximumRoughness+$ TwoWay=�$ PropertyChanged=�6f   �� 5!  "   $��16(�5"     $��Center=�6"   $
��10,0q�6=   ��5!  ,   �� $ maxRoughnessSlider��$ Value�$ {0:F2}��5"  =   5#     5$     ]� 5'     $	��Top=�6$   $��False��69   $	��0,5q�6O   .+�5(     �� $��Minimum Circularity:��6(   $��16(�6D   $��Light"�6R   $��Center=�6e   �� 5)     $ 
Horizontal=�6)   $��Right=�6B   $��Right=�6^   .+�5*  "   �� -   5        $ minCircularitySlider��5*  )   $ 1Q�6G   $ 0Q�6S   $	��230��6_   $
��15,0q�6k   $��Center=�5+  X   $��Right=�6s    6   �� *MinimumCircularity+$ TwoWay=�$ PropertyChanged=�6s   �� 5,  "   $��16(�5-     $��Center=�6   $��Right=�6-   $
��10,0q�6I   ��5,  ,   �� $ minCircularitySlider��$ Value�$ {0:F2}��5-  I   5.     50     ]� 53     $	��Top=�6$   $
��True��69   $	��0,5q�6N   .+�54     �� $��
Reference:��6(   $��16(�6:   $��Light"�6H   $��Center=�6[   $��Right=�6v   �� 55     $ 
Horizontal=�6)   $��Right=�6B   $��Right=�6^   .+�56  "   �� -   5        $ referenceSlider��56  )   $	 255Q�6B   $ 0Q�6P   $	��230��6\   $
��15,0q�6h   $��Center=�57  O    6   �� *	Reference+$ TwoWay=�$ PropertyChanged=�6O   �� 58  "   $��16(�59     $��Center=�6   $��Right=�6-   $��	10,5,10,0q�6I   ��58  ,   �� $ referenceSlider��$ Value�$ {0:0}��59  I   5:     5<     5=     �� 5?     $��
30,0,30,10q�6!   $ Vertical=�65   $
��Left=�6L   $��2��6g   .+�5@     �� $��Name:��6$   $��16(�61   $��Medium"�6?   $
��Left=�6S   $
��0,15q�6n   �� 5A     $��Medium"�5B  "   $
��Left=�5C  "   $��1q�5D  "   $	��250��5E  "   )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Name This Scanning��5F  "   .  (MaterialDesignThemes.Wpf.TextFieldAssist   HasClearButton$
 True��5G  "   ��5A  "   �� *
SetterName+$ TwoWay=�5G  "   5H     5W     �� 5Y     $ 
Horizontal=�6   $��3��66   $��Center=�6C   .+�5Z     �� -   5         ��Name$ startPythonBtn��5Z     $'��!Click Here to Start Python Script��65   $��30q�6a   #��[ 6m   ��6�   �� *RunFlakeDetectionAsyncCommand+� 5[     .+�5]     A� $��50��5^     $��50��6   
�������$��10��6*    J� RenderTransformOrigin$ 0.5,0.5&�5_     y�5`     �� *IsProcessing+ �� 	Converter# [ F� 5d      ) %MaterialDesignDarkSeparatorBackground#��[ 5e     $��10��5f      �� StrokeStartLineCap$
 Flat=�6    �� StrokeEndLineCap$
 Flat=�64   
������ $ 0.5,0.5&�5g     y�5h     �� *IsProcessing+# [ 5k     �� 5m     $��Processing...��5n     $��Center=�5p     $��5q�6    y�5o     �� *IsProcessing+# [ 5p      5q     5s     5v     5w     5x     5z     