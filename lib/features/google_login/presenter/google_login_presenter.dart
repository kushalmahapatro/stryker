import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stryker/features/google_login/presenter/api/google_login_api.dart';
import 'package:stryker/stryker.dart';

class GoogleLoginBloc extends Bloc<LoadAction, LoginResult?> {
  GoogleLoginBloc() : super(null) {
    on<LoginAction>((event, emit) async {
      final result = await googleLoginApi(event.context);

      final fcmToken = await FirebaseMessaging.instance.getToken();

      emit(LoginResult(
          status: result.status,
          email: result.email,
          name: result.name,
          message: result.message));
    });
  }
}

@immutable
class LoginAction implements LoadAction {
  final BuildContext context;

  const LoginAction({
    required this.context,
  }) : super();
}

@immutable
class LoginResult implements FetchResult {
  final bool? status;
  final String? message;
  final String? name;
  final String? email;

  const LoginResult({this.status, this.message, this.name, this.email});

  LoginResult copyWith(
      {bool? status, String? message, String? name, String? email}) {
    return LoginResult(
        status: status ?? this.status,
        message: message ?? this.message,
        email: email ?? this.email,
        name: name ?? this.name);
  }
}
