import 'package:stryker/features/google_login/interactor/google_login_interactor.dart';
import 'package:stryker/features/google_login/presenter/google_login_presenter.dart';
import 'package:stryker/shared/assets/stryker_assets.dart';
import 'package:stryker/stryker.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleLoginBloc, LoginResult?>(
      builder: ((context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StrykerAssets.google.assetImage(height: 30),
            const SizedBox(width: 10),
            'Login with Google'.buttonStyle(context)
          ],
        ).button(
          context,
          onTap: () {
            GoogleLoginInteractor.onGoogleLoginClick(context);
          },
        );
      }),
    );
  }
}
