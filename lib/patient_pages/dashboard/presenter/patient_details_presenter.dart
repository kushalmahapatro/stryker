import 'package:stryker/stryker.dart';

class PatientDetailsBloc extends Bloc<LoadAction, PatientDetailsResult?> {
  PatientDetailsBloc() : super(null) {
    on<PatientDetailsAction>((event, emit) {
      emit(PatientDetailsResult(
        name: event.name,
        email: event.email,
        profileImage: event.profileImage,
      ));
    });
  }
}

@immutable
class PatientDetailsAction implements LoadAction {
  const PatientDetailsAction(
      {required this.name, required this.email, required this.profileImage})
      : super();

  final String name;
  final String email;
  final String profileImage;
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
