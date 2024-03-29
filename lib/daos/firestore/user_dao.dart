import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercestore/models/firestore/user.dart';

class UserDao {
  UserDao._();

  static final instance = UserDao._();

  static const _keyUsers = 'users';

  CollectionReference<User> _getUserColReference() {
    return FirebaseFirestore.instance.collection(_keyUsers).withConverter<User>(
          fromFirestore: (snap, _) => UserCfs.fromSnapshot(snap),
          toFirestore: (user, _) => user.toMap(),
        );
  }

  DocumentReference<User> _getUserReference(String userId) {
    return _getUserColReference().doc(userId);
  }

  Future<void> setUser(User user) async {
    await _getUserReference(user.userId).set(user);
  }

  Future<void> deleteUser(String userId) async {
    await _getUserReference(userId).delete();
  }

  Stream<User> getUserStream(String userId) {
    return _getUserReference(userId).snapshots().map((snap) => snap.data()!);
  }
}
