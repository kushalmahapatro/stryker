const functions = require("firebase-functions");
const admin = require("firebase-admin");


admin.initializeApp(functions.config().firebase);


exports.senddevices = functions.firestore
    .document("tasks/{id}")
    .onCreate( async (snapshot, context) => {
      const patientEmail = snapshot.get("patient");
      const name = snapshot.get("title");
      const subject = snapshot.get("description");

      const payload = {
        notification: {
          title: "from " + name,
          body: "subject " + subject,
          sound: "default",
        },
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

