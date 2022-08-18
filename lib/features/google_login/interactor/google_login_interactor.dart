import 'package:shared_preferences/shared_preferences.dart';
import 'package:stryker/features/google_login/presenter/google_login_presenter.dart';
import 'package:stryker/shared/patient_router.dart';
import 'package:stryker/stryker.dart';

class GoogleLoginInteractor {
  static void onGoogleLoginClick(BuildContext context) {
    var bloc = context.read<GoogleLoginBloc>();
    bloc.add(const LoginAction());

    /// Listen to data changes to Login Event
    bloc.stream.listen((event) async {
      if (event != null) {
        (event.message ?? '').showSnackBar(context);

        /// When status is true save data to
        /// shared Preference and Navigate to Dashboard
        if (event.status ?? false) {
          pref
            ..setBool('loggedIn', true)
            ..setString('name', event.name ?? '')
            ..setString('email', event.email ?? '')
            ..setString('profileImage', event.profileImage ?? '');

          context.goNamed(ScreenName.dashboard.routes);
        }
      }
    });
  }
}
