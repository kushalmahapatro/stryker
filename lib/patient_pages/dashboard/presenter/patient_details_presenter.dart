import 'package:shared_preferences/shared_preferences.dart';
import 'package:stryker/stryker.dart';

class PatientDetailsBloc extends Bloc<LoadAction, PatientDetailsResult?> {
  PatientDetailsBloc() : super(null) {
    on<PatientDetailsAction>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();

      emit(PatientDetailsResult(
        name: pref.getString('name') ?? '',
        email: pref.getString('email') ?? '',
        profileImage: pref.getString('profileImage') ?? '',
      ));
    });
  }
}

@immutable
class PatientDetailsAction implements LoadAction {
  const PatientDetailsAction() : super();
}

@immutable
class PatientDetailsResult implements FetchResult {
  final String? name;
  final String? email;
  final String? profileImage;

  const PatientDetailsResult({
    this.name = '',
    this.email = '',
    this.profileImage = '',
  });

  PatientDetailsResult copyWith(
      {String? name, String? email, String? profileImage}) {
    return PatientDetailsResult(
        email: email ?? this.email,
        name: name ?? this.name,
        profileImage: profileImage ?? this.profileImage);
  }
}
