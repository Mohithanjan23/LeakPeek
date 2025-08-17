import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BreachService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Search for breaches by email
  Future<List<Map<String, dynamic>>> searchBreaches(String email) async {
    try {
      QuerySnapshot snapshot =
          await _firestore
              .collection('breaches')
              .where('emails', arrayContains: email.toLowerCase())
              .get();

      List<Map<String, dynamic>> breaches = [];
      for (var doc in snapshot.docs) {
        breaches.add({'id': doc.id, ...doc.data() as Map<String, dynamic>});
      }

      // Save search to user's history
      await _saveSearchHistory(email, breaches.length);

      return breaches;
    } catch (e) {
      print('Search error: $e');
      return [];
    }
  }

  // Save search history
  Future<void> _saveSearchHistory(String searchTerm, int resultCount) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('search_results')
            .doc(user.uid)
            .collection('searches')
            .add({
              'searchTerm': searchTerm,
              'resultCount': resultCount,
              'timestamp': FieldValue.serverTimestamp(),
            });
      }
    } catch (e) {
      print('Save search history error: $e');
    }
  }

  // Get user's search history
  Future<List<Map<String, dynamic>>> getSearchHistory() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot =
            await _firestore
                .collection('search_results')
                .doc(user.uid)
                .collection('searches')
                .orderBy('timestamp', descending: true)
                .limit(10)
                .get();

        return snapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
            .toList();
      }
      return [];
    } catch (e) {
      print('Get search history error: $e');
      return [];
    }
  }
}
