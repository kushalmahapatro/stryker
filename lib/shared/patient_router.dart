import 'package:stryker/features/google_login/presenter/google_login_presenter.dart';
import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/patient_pages/dashboard/presenter/patient_details_presenter.dart';
import 'package:stryker/stryker.dart';

enum ScreenName { home, dashboard }

extension ScreenNameExtension on ScreenName {
  String get routes => name.toLowerCase();
}

final patientRouter = GoRouter(
    routes: [
      /// Login
      GoRoute(
        name: ScreenName.home.routes,
        path: '/',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: GoogleLoginBloc()),
          ],
          child: const PatientHomePage(),
        ),
      ),

      /// Dashboard
      GoRoute(
        name: ScreenName.dashboard.routes,
        path: '/dashboard',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: PatientDetailsBloc()),
            BlocProvider.value(value: PatientTaskBloc()),
          ],
          child: const PatientDashboardPage(),
        ),
      ),
    ],
    // refreshListenable: GoRouterRefreshStream(stream),
    redirect: (state) {
      if (((pref.getBool('loggedIn') ?? false) && state.location == "/")) {
        return '/dashboard';
      } else {
        return null;
      }
    });
