import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/util/strings.dart';

class JournalService {
  Firestore _service = Firestore.instance;
  
  /// Create new journal item for logged in user
  void createNewJournalItem(Journal journal) {
    print(AuthService.currentUser.uid);
    try {
      DocumentReference ref = _getUserPath()
          .collection(Strings.JOURNALS).document();
      journal.uid = ref.documentID;

      ref.setData(journal.toJson());
    } catch(e) {
      print(e);
    }
  }

  /// Get all journal items from the logged in user
  /// Order journals on date.
  Future<List<Journal>> getJournals() async{
    try {
      QuerySnapshot snapshot =  await _getUserPath().collection(Strings.JOURNALS).orderBy('date', descending: true).getDocuments();
      List<Journal> journals = new List();

      journals = snapshot.documents.map((j) => Journal.fromJson(j.data)).toList();
      return journals;

    } catch(error) {
      print(error);
    }
    return null;
  }

  /// Get total or user journals to show on main screen
  Future<int> getUserTotalJournals() async{
    QuerySnapshot snapshot = await _getUserPath().collection(Strings.JOURNALS).getDocuments();
    List<DocumentSnapshot> docs = snapshot.documents;

    return docs.length;
  }

  /// get a instance of the current user document to not have to repeat it all the time.
  DocumentReference _getUserPath() {
    return _service.collection(Strings.USERS).document(AuthService.currentUser.uid);
  }
}