import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/database/model/app_user.dart';

class UserDao{
  static final _db = FirebaseFirestore.instance;
  static CollectionReference<AppUser> getUserCollection(){
    return _db.collection('users').withConverter<AppUser>(fromFirestore: (
        snapshot, options) => AppUser.fromMAp(snapshot.data())

      ,toFirestore: (user, options) =>user.toMap(),);
  }
  static Future<void> addUser(AppUser user) async {

  var docReference = await getUserCollection()
      .doc(user.userId)
      .set(user);
  }

  void getUserById(String userId)async{
    var doc = await _db.collection('users').doc(userId).get();

    AppUser user = AppUser.fromMAp(doc.data());
  }



}