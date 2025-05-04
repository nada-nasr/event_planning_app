import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/model/my_user.dart';

import 'model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection(uId) {
    return getUsersCollection().doc(uId).collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore:
              (snapshot, options) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (MyUser, options) => MyUser.toJson());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapShot = await getUsersCollection().doc(id).get();
    return querySnapShot.data();
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    var eventsCollection = getEventsCollection(uId);

    /// collection
    DocumentReference<Event> docRef = eventsCollection.doc();

    /// document
    event.id = docRef.id;

    /// auto id
    ///getEventsCollection().doc().set(event);
    return docRef.set(event);
  }
}
