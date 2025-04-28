import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore:
              (snapshot, options) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    var eventsCollection = getEventsCollection();

    /// collection
    DocumentReference<Event> docRef = eventsCollection.doc();

    /// document
    event.id = docRef.id;

    /// auto id
    ///getEventsCollection().doc().set(event);
    return docRef.set(event);
  }
}
