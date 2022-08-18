import 'package:stryker/stryker.dart';

class PatientTaskBloc extends Bloc<LoadAction, PatientTaskResult?> {
  PatientTaskBloc() : super(null) {
    on<PatientTaskAction>((event, emit) async {
      final data = await FirebaseFirestore.instance
          .collection('tasks')
          .where('patient', isEqualTo: pref.get('email'))
          .get();

      List<PatientTasks> tasks = data.docs
          .map(
            (e) => PatientTasks(
              title: e['title'],
              description: e['description'],
              date: e['date'] ?? '',
              time: e['time'] ?? '',
            ),
          )
          .toList();

      emit(PatientTaskResult(status: true, tasks: tasks));
    });
  }
}

class PatientTasks {
  const PatientTasks({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });
  final String title;
  final String description;
  final String date;
  final String time;
}

@immutable
class PatientTaskAction implements LoadAction {
  const PatientTaskAction() : super();
}

@immutable
class PatientTaskResult implements FetchResult {
  final List<PatientTasks>? tasks;
  final bool? status;

  const PatientTaskResult({
    this.tasks,
    this.status = false,
  });

  PatientTaskResult copyWith({
    List<PatientTasks>? tasks,
    bool? status,
  }) {
    return PatientTaskResult(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
    );
  }
}
