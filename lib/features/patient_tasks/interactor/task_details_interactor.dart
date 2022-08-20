import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/stryker.dart';

class TaskDetailsInteractor {
  static void onChangeStatus({
    required String id,
    required int status,
    required BuildContext context,
  }) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .update({'status': status}).then((value) {
      context
          .read<PatientTaskBloc>()
          .add(PatientTaskAction(email: pref.get('email').toString()));
      Navigator.of(context).pop();
      "Status updated successfully".showSnackBar(context);
    }).onError((error, stackTrace) {
      'Error in updating status'.showSnackBar(context);
    });
  }
}
