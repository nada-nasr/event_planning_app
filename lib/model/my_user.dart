class MyUser {
  // data class - model
  static const String collectionName = 'Users';
  String id;
  String name;
  String email;
  double? latitude;
  double? longitude;

  MyUser({
    required this.id,
    required this.name,
    required this.email,
    this.latitude,
    this.longitude,
  });

  //todo: ison => object
  MyUser.fromJson(Map<String, dynamic> data) : this(
    id: data['id'] as String,

    /// casting
    name: data['name'] as String,
    email: data['email'] as String,
        latitude: (data['latitude'] as num?)?.toDouble(),
        longitude: (data['longitude'] as num?)?.toDouble(),
      );

  //todo: object => json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}