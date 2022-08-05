import 'package:stryker/features/google_login/presenter/google_login_presenter.dart';
import 'package:stryker/patient_pages/home/home_page.dart';
import 'package:stryker/stryker.dart';

enum ScreenName {
  home,
}

extension ScreenNameExtension on ScreenName {
  String get routes => name.toLowerCase();
}

final patientRouter = GoRouter(routes: [
  /// Dashboard
  GoRoute(
    name: ScreenName.home.routes,
    path: '/',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GoogleLoginBloc()),
      ],
      child: const HomePage(),
    ),
  ),
]);
