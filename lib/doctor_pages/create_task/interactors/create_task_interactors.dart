import 'package:intl/intl.dart';
import 'package:stryker/stryker.dart';

class CreateTaskInteractors {
  static void backClick(BuildContext context) {
    context.pop();
  }

  static void saveTask(BuildContext context, String title, String description,
      String patient) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    String date = DateFormat('dd MMM yyyy').format(DateTime.now());
    String time = DateFormat('hh:mm a').format(DateTime.now());

    tasks
        .add({
          'title': title,
          'description': description,
          'patient': patient,
          'date': date,
          'time': time,
          'status': 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch
        })
        .then((value) => 'Task created successfully'.showSnackBar(context))
        .catchError((error) => 'Error in creating task'.showSnackBar(context));

    context.pop();
  }
}
