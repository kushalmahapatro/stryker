import 'package:stryker/features/google_login/presenter/google_login_presenter.dart';
import 'package:stryker/stryker.dart';

class GoogleLoginInteractor {
  static void onGoogleLoginClick(BuildContext context) {
    context.read<GoogleLoginBloc>().add(LoginAction(context: context));
  }
}
