import 'package:stryker/doctor_pages/create_task/create_task_page.dart';
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
      builder: (context, state) => const DashboardPage(),
    ),

    GoRoute(
      name: ScreenName.createTask.routes,
      path: '/create/task',
      builder: (context, state) => const CreateTaskPage(),
    ),
  ],
);
