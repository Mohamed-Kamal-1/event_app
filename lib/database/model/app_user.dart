class AppUser {
  String? userId;
  String? email;
  String? name;
  String? phone;

  AppUser({this.userId, this.email, this.name, this.phone});

  AppUser.fromMAp(Map<String, dynamic>? map) {
    userId =  map?['id'];
    email  =  map?['email'];
    name   =  map?['name'];
    phone  =  map?['phone'];
  }

  Map<String, dynamic> toMap() {
    return {'id': userId, 'email': email, 'name': name, 'phone': phone};
  }
}
