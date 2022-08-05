import 'package:google_sign_in/google_sign_in.dart';
import 'package:stryker/features/google_login/entity/api_return.dart';
import 'package:stryker/stryker.dart';

Future<ApiReturn> googleLoginApi(
  BuildContext context,
) async {
  /// Google login API call
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        'com.googleusercontent.apps.170901196685-lludvo7hj19vprdl742vo61492bhv19s',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  String returnMsg = "";
  String name = "";
  String email = "";
  bool val = false;
  try {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if ((account?.id ?? '').isNotEmpty) {
      returnMsg = "Welcome ${account?.displayName ?? ''}";
      val = true;
      email = account?.email ?? '';
      name = account?.displayName ?? '';
    } else {
      returnMsg = "Something wrong happened while trying to login with Google";
    }
  } catch (error) {
    debugPrint(error.toString());
    returnMsg = "Something wrong happened  while trying to login with Google";
  }

  await Future.delayed(const Duration(milliseconds: 1200));
  return ApiReturn(val, returnMsg, name, email);
}
