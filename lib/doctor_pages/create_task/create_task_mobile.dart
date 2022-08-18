import 'package:stryker/doctor_pages/dashboard/components/dashboard_appbar.dart';
import 'package:stryker/stryker.dart';

class CreateTaskMobile extends StatelessWidget {
  const CreateTaskMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(
        isDesktop: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [],
              ),
              Text(
                'Welcome Doctor',
                style:
                    context.displaySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
