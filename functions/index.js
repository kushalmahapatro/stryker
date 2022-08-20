const functions = require("firebase-functions");
const admin = require("firebase-admin");


admin.initializeApp(functions.config().firebase);


exports.senddevices = functions.firestore
  .document("tasks/{id}")
  .onCreate(async (snapshot, context) => {
    const patientEmail = snapshot.get("patient");
    const title = snapshot.get("title");
    const id = context.params.id;
    // const description = snapshot.get("description");

    const payload = {
      notification: {
        title: "New task has been assigned",
        body: title,
        sound: "default",
      },
      data: {
        id: id,
    }
    };
    let tokens = "";
    console.log(patientEmail);
    const collRef = admin.firestore().collection("patients");
    const coll = await collRef.where("email", "==", patientEmail).get();
    coll.forEach((doc) => {
      console.log(doc.id, "=>", doc.data());
      tokens = doc.get('fcmToken');
    });

    console.log(tokens);
    return admin.messaging()
      .sendToDevice(tokens, payload).then((response) => {
        console.log("pushed them all");
      }).catch((err) => {
        console.log(err);
      });
  }
  );

