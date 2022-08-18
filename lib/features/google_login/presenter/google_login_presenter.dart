import 'package:stryker/features/google_login/presenter/api/add_patient_data.dart';
import 'package:stryker/features/google_login/presenter/api/google_login_api.dart';
import 'package:stryker/stryker.dart';

class GoogleLoginBloc extends Bloc<LoadAction, LoginResult?> {
  GoogleLoginBloc() : super(null) {
    on<LoginAction>((event, emit) async {
      final result = await googleLoginApi();
      if (result.status) {
        final data = await addPatientData(
          email: result.email,
          name: result.name,
          profileImage: result.profileImage,
        );
        if (data.error.isEmpty) {
          emit(LoginResult(
              status: result.status,
              email: result.email,
              name: result.name,
              profileImage: result.profileImage,
              message: "login successful"));
        } else {
          emit(const LoginResult(
            status: false,
            message: 'Error in Adding Patient Data',
          ));
        }
      } else {
        emit(const LoginResult(
          status: false,
          message: 'Error in Google Signin',
        ));
      }
    });
  }
}

@immutable
class LoginAction implements LoadAction {
  const LoginAction() : super();
}

@immutable
class LoginResult implements FetchResult {
  final bool? status;
  final String? message;
  final String? name;
  final String? email;
  final String? profileImage;

  const LoginResult({
    required this.status,
    required this.message,
    this.name = '',
    this.email = '',
    this.profileImage = '',
  });

  LoginResult copyWith(
      {bool? status,
      String? message,
      String? name,
      String? email,
      String? profileImage}) {
    return LoginResult(
        status: status ?? this.status,
        message: message ?? this.message,
        email: email ?? this.email,
        name: name ?? this.name,
        profileImage: profileImage ?? this.profileImage);
  }
}
