   M S B A M L   `   `   `  ����B  >MyToDo1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:MyToDo1.ExtentionsMyToDo1.Extentions  5	   	   !clr-namespace:MyToDo1MyToDo1  5   	   =#clr-namespace:MyToDo1.Common.ModelsMyToDo1.Common.Models  5   	   7 clr-namespace:MyToDo1.ViewModelsMyToDo1.ViewModels  5   	       MyToDo1.Views.MainView   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   ] YPrism.DryIoc.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59V	 RPrism.Wpf, Version=9.0.537.60525, Culture=neutral, PublicKeyToken=40ee6c3a2184dc59&prismhttp://prismlibrary.com/  	 5   	   _
 [Microsoft.Xaml.Behaviors, Version=1.1.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a3i+http://schemas.microsoft.com/xaml/behaviors 
 5   	   *ext clr-namespace:MyToDo1.Extentions 
 5	   	   !localclr-namespace:MyToDo1 
 5   	   0models#clr-namespace:MyToDo1.Common.Models 
 5   	   1
viewmodels clr-namespace:MyToDo1.ViewModels 
 5   	   ! 	 Prism.Mvvm.ViewModelLocator    AutoWireViewModel  True5
   	      MaterialDesignWindow#��[  5   	    � Title$ 
MainWindow��5   	   $	��768��5   	   $
��1280��5   	    � WindowStyle$
 None=�5   	    � WindowStartupLocation$ CenterScreen=�5   	    � AllowsTransparency$
 True��5   	   $��Segoe UI)�5   	   .��5      )  #MaterialDesignThemes.Wpf.DialogHost     DialogTheme$ Inherit=�6       
Identifier$ 
RootDialog��5         SnackbarMessageQueue 5      ��  �� ElementName$ MainSnackbar��	 �� Path$	 MessageQueue�.��5   
   )  #MaterialDesignThemes.Wpf.DrawerHost  -   5        
  Name$
 
drawerHost��5   $      IsLeftDrawerOpen 68   �� $ MenuToggleButton��$	 	IsChecked�   LeftDrawerContent 5      ]� 5      $	��220��6   .+�5       �� $��	0,50,0,20q�6!   $	��Top=�64   .+�5!      � .+�5"      �� $��50��6C   $��50��6O   ��6$   �� *ImageSource+6O   �� 5#      $��70��6%   $��70��60   ���#FFFFFF J� Opacity$	 0.1Q�6Q    �� CornerRadius$ 50��6_   5$      �� 5%      $
��Jeff��6"   $�� 0,10q�6.   $��Center=�6=    �� 
IsReadOnly$
 True��6Z    J� IsHitTestVisible$ False��6l   $|�False��6�   5&      �� 5'      -   5         ��Name$ menuBar��5'      ��6/   �� *
MenuBars+* 
 $Microsoft.Xaml.Behaviors.Interaction   Triggers 5(      + 
 %Microsoft.Xaml.Behaviors.EventTrigger  5)         	EventName$ SelectionChanged��6-   * 
 $Microsoft.Xaml.Behaviors.TriggerBase   Actions. 5*   "   2 
 ,Microsoft.Xaml.Behaviors.InvokeCommandAction     Command 68   �� *NavigateCommand+   CommandParameter 6\   �� $ menuBar��$	 SelectedItem�5+      ��5-      �� 5.      .R�5/   "   ��  �� Orientation$ 
Horizontal=�6-   .+�50   &   '  !MaterialDesignThemes.Wpf.PackIcon  $
��15,0q�6T   $��Center=�6b      Kind 6>   �� *Icon+6b   �� 51   &   $
��10,0q�60   $��Center=�6U   ��6>   �� *Title+6U   52   #   54      56      58      .��5;      ]� -   5         ]�Name$ 	ColorZone��5;      .+�5<      (	  "MaterialDesignThemes.Wpf.ColorZone	  -   5         	 Name$ 
ColorZone2��5=      $��16q�5>      .
  (MaterialDesignThemes.Wpf.ElevationAssist 
  	Elevation$	 Dp4=�5?      $	��Top=�5@       	  Mode$ 
PrimaryMid=�5A      .��5B      ]� $��False��6    .+�5C      �� $ 
Horizontal=�6%   .+�5D      d� -   5         d�Name$ MenuToggleButton��5D   +   4  .System.Windows.Automation.AutomationProperties   Name$ HamburgerToggleButton��5E       d� 	IsChecked$ FalseY�5G       ' #MaterialDesignHamburgerToggleButton#��[ 5H        � Cursor$
  Hand��5I      �� 5K      -   5        $��24,0,0,0q�5K   %     MaterialDesignToolButton#��[ 5Q   !   ! � ToolTip$! Previous Item��5R   !   +  %MaterialDesignThemes.Wpf.RippleAssist"   Feedback" 5L   !   �� # �� RelativeSource# �� *Self+$	 
Foreground�  BrushRoundConverter$ �� 	Converter#$ [ ��5M   !   �� *GoBackCommand+��5N   !   0  *MaterialDesignThemes.Wpf.PackIconExtension  %   Kind$% 	ArrowLeft=�&   Size& 24��5P   !   �� # �� ' �� AncestorType"' �$	 (TextElement.Foreground)�5R   9   �� 5T      $��16,0,0,0q�6%   #��[ 5Z   !   $! 	Next Item��5[   !   " 5U   !   �� # �� *Self+$	 
Foreground�#$ [ ��5V   !   �� *GoForwardCommand+��5W   !     $% 
ArrowRight=�& 24��5Y   !   �� # �� "' �$	 (TextElement.Foreground)�5[   !   �� 5]      -   5        $��16,0,0,0q�5]   %   #��[ 5c      $
! Home��5d      " 5^      �� # �� *Self+$	 
Foreground�#$ [ ��5_      �� *HomeCommand+��5`        $
% Home=�& 24��5b      �� # �� "' �$	 (TextElement.Foreground)�5d   $   �� 5f      $��16,0,0,0q�6(   $��Center=�5g   !   $��Center=�5h   !   $% Material Design In XAML Toolkit��5i   !   $��22(�5j   !   $��My Flake Inspector��5k   !   5m      �� 5o      $��Right=�6%   $ 
Horizontal=�6<   $��24,0,0,0q�6U   .+�5p      �� $��28��6C   $��28��6O   ��6$   �� *ImageSource+( J� Clip( 5q   "   @� 5r   &   ) @� Center$) 14,14&�66   * @� RadiusX$* 14Q�6E   + @� RadiusY$+ 14Q�6R   5t      �� 5v      -   5        , ��Name$, btnMin��5v   %    ! MaterialDesignFlatMidBgButton#��[ 65   .��5w   "     $ WindowMinimize=�6:   $��24��6P   $��24��6[   5x      �� 5z      -	   5        $, btnMax��5z   %   #��[ 65   ��6l   �� *MaximizeCommand+.��5{   "     -
   5        $��maxPackIcon��5{   :   $��24��6M   $��24��6X   5|      �� 5~      -   5        $, btnClose��5~   %   #��[ 67   .��5   "     $ Close=�6:   $��24��6G   $��24��6R   5�      5�      5�      5�      �� 5�      %   MyToDo1.Extentions.PrismManager-   MainViewRegionName, 	 &Prism.Navigation.Regions.RegionManager.   
RegionName#. Z- 6!   5�      5�      5�      5�      