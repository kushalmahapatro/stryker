import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stryker/stryker.dart';

Future<AddPatientDataResult> addPatientData({
  required String email,
  required String name,
  required String profileImage,
}) async {
  CollectionReference tasks = FirebaseFirestore.instance.collection('patients');

  bool added = false;
  String error = '';

  var data = await tasks.where('email', isEqualTo: email).get();
  final fcmToken = await FirebaseMessaging.instance.getToken();

  if (data.size == 0) {
    await tasks
        .add({
          'email': email,
          'name': name,
          'profileImage': profileImage,
          'fcmToken': [fcmToken]
        })
        .then((value) => added = true)
        .catchError((error) {
          error = "Error adding Patient";
          return true;
        });
  } else {
    var token = data.docs[0].get('fcmToken') as List;
    token.add(fcmToken ?? '');
    await tasks
        .doc(data.docs[0].id)
        .update({
          'name': name,
          'profileImage': profileImage,
          'fcmToken': token.toSet().toList()
        })
        .then((value) => added = true)
        .catchError((error) {
          error = "Error adding Patient";
          return true;
        });
  }

  return AddPatientDataResult(status: added, error: error);
}

class AddPatientDataResult {
  AddPatientDataResult({
    required this.status,
    required this.error,
  });

  final bool status;
  final String error;
}
