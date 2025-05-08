import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  // data class - model
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  String time;
  DateTime dateTime;
  bool isFavourite;

  Event({
    this.id = '',
    required this.image,
    required this.title,
    required this.description,
    required this.eventName,
    required this.time,
    required this.dateTime,
    this.isFavourite = false
  });

  //todo: ison => object
  Event.fromJson(Map<String, dynamic> data)
    : this(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        image: data['image'],
        eventName: data['eventName'],
        time: data['time'],
    dateTime: data['dateTime'] != null
        ? (data['dateTime'] is Timestamp
        ? (data['dateTime'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(data['dateTime'] as int))
        : DateTime.now(),

    ///DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
        isFavourite: data['isFavourite'],
      );

  //todo: object => json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'eventName': eventName,
      'time': time,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isFavourite': isFavourite,
    };
  }
}
