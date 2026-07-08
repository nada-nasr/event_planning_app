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
  double? latitude;
  double? longitude;
  String? locationName;

  Event({
    this.id = '',
    required this.image,
    required this.title,
    required this.description,
    required this.eventName,
    required this.time,
    required this.dateTime,
    this.isFavourite = false,
    this.latitude,
    this.longitude,
    this.locationName,
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
    latitude: (data['latitude'] as num?)?.toDouble(),
    longitude: (data['longitude'] as num?)?.toDouble(),
    locationName: data['locationName'] as String?,
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
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
    };
  }

  Event copyWith({
    String? id,
    String? image,
    String? title,
    String? description,
    String? eventName,
    String? time,
    DateTime? dateTime,
    bool? isFavourite,
    double? latitude,
    double? longitude,
    String? locationName,
  }) {
    return Event(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      eventName: eventName ?? this.eventName,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
      isFavourite: isFavourite ?? this.isFavourite,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
    );
  }
}
