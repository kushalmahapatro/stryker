import 'package:stryker/shared/patient_router.dart';
import 'package:stryker/stryker.dart';

class DashboardInteractors {
  static void logoutClick(BuildContext context) {
    pref.clear().then((value) => context.goNamed(ScreenName.home.routes));
  }
}
