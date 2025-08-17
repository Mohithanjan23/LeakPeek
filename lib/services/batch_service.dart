class BatchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Batch import breaches
  Future<void> batchImportBreaches(List<BreachModel> breaches) async {
    WriteBatch batch = _firestore.batch();

    try {
      for (BreachModel breach in breaches) {
        DocumentReference docRef =
            _firestore.collection('breaches').doc(breach.name);
        batch.set(docRef, breach.toFirestore());
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch import breaches: $e');
    }
  }

  // Batch update user preferences
  Future<void> batchUpdateUserPreferences(
      List<String> userIds, Map<String, dynamic> preferences) async {
    WriteBatch batch = _firestore.batch();

    try {
      for (String userId in userIds) {
        DocumentReference docRef = _firestore.collection('users').doc(userId);
        batch.update(docRef, {'preferences': preferences});
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch update user preferences: $e');
    }
  }

  // Batch delete old search results
  Future<void> batchDeleteOldSearchResults(
      String userId, DateTime olderThan) async {
    QuerySnapshot snapshot = await _firestore
        .collection('search_results')
        .doc(userId)
        .collection('searches')
        .where('searchDate', isLessThan: Timestamp.fromDate(olderThan))
        .get();

    WriteBatch batch = _firestore.batch();

    try {
      for (DocumentSnapshot doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch delete old search results: $e');
    }
  }
}
