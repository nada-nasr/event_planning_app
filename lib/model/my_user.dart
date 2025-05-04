class MyUser {
  // data class - model
  static const String collectionName = 'Users';
  String id;
  String name;
  String email;

  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });

  //todo: ison => object
  MyUser.fromJson(Map<String, dynamic> data) : this(
    id: data['id'] as String,

    /// casting
    name: data['name'] as String,
    email: data['email'] as String,

  );

  //todo: object => json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}