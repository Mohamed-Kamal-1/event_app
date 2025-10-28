class AppUser {
  String? userId;
  String? email;
  String? name;
  String? phone;
  List<String> favorites;

  AppUser({
    this.userId,
    this.email,
    this.name,
    this.phone,
    this.favorites = const [],
  });

  AppUser.fromMAp(Map<String, dynamic>? map)
      : this(
      userId: map?['id'],
      email: map?['email'],
      name: map?['name'],
      phone: map?['phone'],
      favorites: (map?['favorites'] as List<dynamic>)
          .map((e) => e.toString(),).toList()
  );

  Map<String, dynamic> toMap() {
    return {'id': userId, 'email': email, 'name': name, 'phone': phone, 'favorites': favorites};
  }
}
