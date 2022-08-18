import 'package:stryker/doctor_pages/dashboard/components/dashboard_appbar.dart';
import 'package:stryker/stryker.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(isDesktop: false),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          'Welcome Doctor',
          style: context.displaySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
