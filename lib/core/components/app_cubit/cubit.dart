import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/before_after/presentation/pages/before_after_screen.dart';
import 'package:manicann/features/bookings/presentation/pages/current_bookings_screen.dart';
import 'package:manicann/features/branches/presentation/pages/all_branches_screen.dart';
import 'package:manicann/features/clients/presentation/pages/clients_screen.dart';
import 'package:manicann/features/complaints/presentation/pages/complaints_screen.dart';
import 'package:manicann/features/employees/presentation/pages/employees_screen.dart';
import 'package:manicann/features/offers/presentation/pages/offers_screen.dart';
import 'package:manicann/features/services/presentation/pages/services_screen.dart';
import 'package:manicann/features/statistic/presentation/pages/statistic_screen.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState()) {
    // selectedScreenIndex = AppLink.branchId == '0' ? 1 : 0;
    initialListScreen();
  }
  List screensConst = [];
  List screens = [];
  static AppCubit get(context) => BlocProvider.of(context);

  int selectedScreenIndex = 1;
  int lastScreen = 1;

  void updateSelected(int newScreenIndex) {
    if (newScreenIndex != screensConst.length - 1) {
      selectedScreenIndex = newScreenIndex;
      screens[selectedScreenIndex] = screensConst[selectedScreenIndex];
      emit(ScreenNavigationState());
      // lastScreen = newScreenIndex;
    }
    // else {
    //   screens[newScreenIndex] = screensConst[lastScreen];
    //   selectedScreenIndex = newScreenIndex;
    //   emit(ScreenNavigationState());
    // }
  }

  initialListScreen() {
    print('selectedScreenIndex $selectedScreenIndex');
    screens = [
      const StatisticsScreen(),
      const EmployeesScreen(),
      const BranchCurrentBookingsScreen(),
      const ClientsScreen(),
      const ServicesScreen(),
      const OffersScreen(),
      const BeforeAfterScreen(),
      const ComplaintsScreen(),
      const StatisticsScreen(),
    ];
    screensConst = [
      const StatisticsScreen(),
      const EmployeesScreen(),
      const BranchCurrentBookingsScreen(),
      const ClientsScreen(),
      const ServicesScreen(),
      const OffersScreen(),
      const BeforeAfterScreen(),
      const ComplaintsScreen(),
      const StatisticsScreen(),
    ];
    if (AppLink.role == 'admin') {
      screensConst.insert(
        1,
        const BranchesScreen(),
      );
      screens.insert(
        1,
        const BranchesScreen(),
      );
    }
  }

  bool empTableRightClickHovered = false;
  bool empTableLeftClickHovered = false;

  void hoverClick(int direction) {
    if (direction == -1) {
      empTableLeftClickHovered = true;
    } else {
      empTableRightClickHovered = true;
    }
    emit(HoverState());
  }

  void cancelHoverClick(int direction) {
    if (direction == -1) {
      empTableLeftClickHovered = false;
    } else {
      empTableRightClickHovered = false;
    }
    emit(CancelHoverState());
  }
}
