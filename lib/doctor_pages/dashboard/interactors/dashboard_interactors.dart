import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/shared/router.dart';
import 'package:stryker/stryker.dart';

class DashboardInteractors {
  static void createTaskClick(BuildContext context, String email) async {
    context.pushNamed(ScreenName.createTask.routes);

    if (email.isNotEmpty) {
      context.read<PatientTaskBloc>().add(PatientTaskAction(
            email: email,
          ));
    }

    // context.pushNamed(ScreenName.createTask.routes)
  }
}
