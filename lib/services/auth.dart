import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_journaling/models/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  static User currentUser;

  /// Register a new user with email and password
  Future register(String name, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Change display name of user
      _setDisplayName(user, name);
      _createUserDocument(user.uid);

      return _createUserFromFirebaseUser(user);
    } catch(e) {
      return null;
    }
  }

  /// Login user with email and password.
  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _createUserFromFirebaseUser(user);
    } catch(e) {
      return null;
    }
  }

  /// Sign out current user.
  Future signOut() async {
    try {
      currentUser = null;
      return await _auth.signOut();
    } catch(e) {

    }
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_createUserFromFirebaseUser);
  }


  /// Update display name when a new user is registered.
  void _setDisplayName(FirebaseUser user, String name) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = name;

    user.updateProfile(updateInfo);
  }

  void _createUserDocument(String uid) {
    Firestore.instance.collection('users').document(uid).setData({});
  }

  /// Create user from firebase
  User _createUserFromFirebaseUser(FirebaseUser user) {
    if(user != null) {
      var currentUser = User(uid: user.uid, name: user.displayName, email: user.email);
      AuthService.currentUser = currentUser;
      return currentUser;
    }
    return null;
  }
}