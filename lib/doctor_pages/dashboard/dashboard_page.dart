import 'package:stryker/doctor_pages/dashboard/dashboard_desktop.dart';
import 'package:stryker/doctor_pages/dashboard/dashboard_mobile.dart';
import 'package:stryker/stryker.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.isMobile) {
        return const DashboardMobile();
      } else {
        return const DashboardDesktop();
      }
    });
  }
}
