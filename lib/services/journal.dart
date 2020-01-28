import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/util/strings.dart';

class JournalService {
  Firestore _service = Firestore.instance;
  AuthService _auth = AuthService();
  
  /// Create new journal item for logged in user
  void createNewJournalItem(Journal journal) {
    _getUserPath()
        .collection(Strings.JOURNALS).document().setData(
        {
          'questions': journal.questions,
          'date': journal.date,
          'journal': journal.journal
        }
        );
  }

  /// Get all journal items from the logged in user
  Future<List<Journal>> getJournals() async {
    final QuerySnapshot result = await _getUserPath().collection(Strings.JOURNALS).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;

    // j => Journal item
    return documents.map((j) => new Journal(j['journal'], j['questions'], j['date'], j.documentID))
    .toList();
  }

  /// get a instance of the current user document to not have to repeat it all the time.
  DocumentReference _getUserPath() {
    return _service.collection(Strings.USERS).document(_auth.getCurrentUser().uid);
  }
}