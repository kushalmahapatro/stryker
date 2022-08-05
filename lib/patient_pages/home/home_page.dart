import 'package:stryker/features/google_login/view/google_login_button.dart';
import 'package:stryker/shared/assets/stryker_assets.dart';
import 'package:stryker/stryker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StrykerAssets.logo.assetImage(width: 100).paddingAll(10),

          const SizedBox(
            height: 40,
          ),

          /// Google login button
          const GoogleLoginButton()
        ],
      ).paddingAll(20),
    );
  }
}
