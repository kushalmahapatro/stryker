const functions = require("firebase-functions");
const admin = require("firebase-admin");


admin.initializeApp(functions.config().firebase);

exports.senddevices = functions.firestore
    .document("tasks/{id}")
    .onCreate((snapshot, context) => {
      const name = snapshot.get("title");
      const subject = snapshot.get("description");
      const token = snapshot.get("token");

      const payload = {
        notification: {
          title: "from " + name,
          body: "subject " + subject,
          sound: "default",
        },
      };

      return admin.messaging()
          .sendToDevice(token, payload).then((response) => {
            console.log("pushed them all");
          }).catch((err) => {
            console.log(err);
          });
    }
    );
