import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/features/patient_tasks/view/task_detail_view.dart';
import 'package:stryker/shared/patient_router.dart';
import 'package:stryker/stryker.dart';

class DashboardInteractors {
  static void logoutClick(BuildContext context) {
    pref.clear().then((value) => context.goNamed(ScreenName.home.routes));
  }

  static void onTaskClick(BuildContext context, PatientTasks task) {
    showModalBottomSheet(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return taskDetailsView(
            context: context,
            task: task,
          );
        });
  }
}
