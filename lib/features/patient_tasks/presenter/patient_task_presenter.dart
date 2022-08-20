import 'package:stryker/stryker.dart';

class PatientTaskBloc extends Bloc<LoadAction, PatientTaskResult?> {
  PatientTaskBloc() : super(null) {
    on<PatientTaskAction>((event, emit) async {
      final data = await FirebaseFirestore.instance
          .collection('tasks')
          .where('patient', isEqualTo: event.email)
          .orderBy('timestamp', descending: true)
          .get();

      final pendingData = await FirebaseFirestore.instance
          .collection('tasks')
          .where('patient', isEqualTo: event.email)
          .where('status', isEqualTo: 0)
          .orderBy('timestamp', descending: true)
          .get();

      final progressData = await FirebaseFirestore.instance
          .collection('tasks')
          .where('patient', isEqualTo: event.email)
          .where('status', isEqualTo: 1)
          .orderBy('timestamp', descending: true)
          .get();

      final completedData = await FirebaseFirestore.instance
          .collection('tasks')
          .where('patient', isEqualTo: event.email)
          .where('status', isEqualTo: 2)
          .orderBy('timestamp', descending: true)
          .get();

      List<PatientTasks> tasks = data.docs.map((e) {
        int status = 0;
        try {
          status = e.get('status');
        } catch (_) {}
        return PatientTasks(
          id: e.id,
          title: e['title'],
          description: e['description'],
          date: e['date'] ?? '',
          time: e['time'] ?? '',
          status: status,
        );
      }).toList();

      List<PatientTasks> pendingTasks = pendingData.docs.map((e) {
        int status = 0;
        try {
          status = e.get('status');
        } catch (_) {}
        return PatientTasks(
          id: e.id,
          title: e['title'],
          description: e['description'],
          date: e['date'] ?? '',
          time: e['time'] ?? '',
          status: status,
        );
      }).toList();

      List<PatientTasks> progressTasks = progressData.docs.map((e) {
        int status = 0;
        try {
          status = e.get('status');
        } catch (_) {}
        return PatientTasks(
          id: e.id,
          title: e['title'],
          description: e['description'],
          date: e['date'] ?? '',
          time: e['time'] ?? '',
          status: status,
        );
      }).toList();
      List<PatientTasks> completedTasks = completedData.docs.map((e) {
        int status = 0;
        try {
          status = e.get('status');
        } catch (_) {}
        return PatientTasks(
          id: e.id,
          title: e['title'],
          description: e['description'],
          date: e['date'] ?? '',
          time: e['time'] ?? '',
          status: status,
        );
      }).toList();

      PatientTasks? task;
      if ((event.id ?? '').isNotEmpty) {
        task = tasks.firstWhere(
          (element) => element.id == event.id,
        );
      }

      emit(PatientTaskResult(
        status: true,
        tasks: tasks,
        pendingTasks: pendingTasks,
        progressTasks: progressTasks,
        completedTasks: completedTasks,
        task: task,
      ));
    });
  }
}

class PatientTasks {
  const PatientTasks({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.id,
    required this.status,
  });
  final String title;
  final String description;
  final String date;
  final String time;
  final String id;
  final int status;
}

@immutable
class PatientTaskAction implements LoadAction {
  const PatientTaskAction({required this.email, this.id = ''}) : super();

  final String? id;
  final String email;
}

@immutable
class PatientTaskResult implements FetchResult {
  final List<PatientTasks>? tasks;
  final List<PatientTasks>? pendingTasks;
  final List<PatientTasks>? progressTasks;
  final List<PatientTasks>? completedTasks;
  final PatientTasks? task;
  final bool? status;

  const PatientTaskResult({
    this.tasks,
    this.pendingTasks,
    this.progressTasks,
    this.completedTasks,
    this.task,
    this.status = false,
  });

  PatientTaskResult copyWith({
    List<PatientTasks>? tasks,
    List<PatientTasks>? pendingTasks,
    List<PatientTasks>? progressTasks,
    List<PatientTasks>? completedTasks,
    PatientTasks? task,
    bool? status,
  }) {
    return PatientTaskResult(
      tasks: tasks ?? this.tasks,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      progressTasks: progressTasks ?? this.progressTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      task: task ?? this.task,
      status: status ?? this.status,
    );
  }
}
