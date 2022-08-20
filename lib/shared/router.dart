import 'package:stryker/doctor_pages/create_task/create_task_page.dart';
import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/patient_pages/dashboard/presenter/patient_details_presenter.dart';
import 'package:stryker/stryker.dart';

enum ScreenName {
  dashboard,
  createTask,
}

extension ScreenNameExtension on ScreenName {
  String get routes => name.toLowerCase();
}

final doctorRouter = GoRouter(
  routes: [
    /// Dashboard
    GoRoute(
      name: ScreenName.dashboard.routes,
      path: '/',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: PatientDetailsBloc()),
          BlocProvider.value(value: PatientTaskBloc()),
        ],
        child: const DashboardPage(),
      ),
    ),

    GoRoute(
      name: ScreenName.createTask.routes,
      path: '/create/task',
      builder: (context, state) => const CreateTaskPage(),
    ),
  ],
);
