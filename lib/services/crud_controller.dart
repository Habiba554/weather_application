import 'package:cloud_firestore/cloud_firestore.dart';

class Crud {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addReport(String userId, String title, String desc) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('reports')
          .add({
        'title': title,
        'description': desc,
        'dateReported': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }


}
