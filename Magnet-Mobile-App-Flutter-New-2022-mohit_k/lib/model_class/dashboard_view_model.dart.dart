import 'package:magnet_update/custom_widgets/dashboard_class_widget.dart';

class DashBoardPageViewModel {
  DashboardPageState? state;
  int menuIndex = 0;
  DashBoardPageViewModel(DashboardPageState? state)
  {
    menuIndex = state!.widget.index;
  }
}
