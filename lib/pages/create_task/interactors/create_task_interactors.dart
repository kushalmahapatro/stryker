import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stryker/stryker.dart';

class CreateTaskInteractors {
  static void backClick(BuildContext context) {
    context.pop();
  }

  static void saveTask(BuildContext context, String title, String description,
      String patient) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    tasks
        .add({'title': title, 'description': description, 'patient': patient})
        .then((value) => 'Task created successfully'.showSnackBar(context))
        .catchError((error) => 'Error in creating task'.showSnackBar(context));

    context.pop();
  }
}
