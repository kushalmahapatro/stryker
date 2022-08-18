import 'package:google_sign_in/google_sign_in.dart';
import 'package:stryker/features/google_login/entity/api_return.dart';
import 'package:stryker/firebase_options.dart';
import 'package:stryker/stryker.dart';

Future<ApiReturn> googleLoginApi() async {
  /// Google login API call
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
  );

  String returnMsg = "";
  String name = "";
  String email = "";
  String profileImage = '';
  bool val = false;
  try {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if ((account?.id ?? '').isNotEmpty) {
      returnMsg = "Welcome ${account?.displayName ?? ''}";
      val = true;
      email = account?.email ?? '';
      name = account?.displayName ?? '';
      profileImage = account?.photoUrl ?? '';
    } else {
      returnMsg = "Something wrong happened while trying to login with Google";
    }
  } catch (error) {
    debugPrint(error.toString());
    returnMsg = "Something wrong happened  while trying to login with Google";
  }

  await Future.delayed(const Duration(milliseconds: 1200));
  return ApiReturn(val, returnMsg, name, email, profileImage);
}
