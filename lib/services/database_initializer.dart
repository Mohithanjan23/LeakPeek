import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseInitializer {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initialize database with sample data
  Future<void> initializeDatabase() async {
    try {
      await _createIndexes();
      await _seedSampleBreaches();
      await _createSystemCollections();
      print('Database initialized successfully');
    } catch (e) {
      print('Database initialization failed: $e');
      throw e;
    }
  }

  // Create database indexes for better performance
  Future<void> _createIndexes() async {
    try {
      // Note: Indexes are typically created through Firebase Console
      // or using Firebase CLI. This is for documentation purposes.

      // Recommended indexes:
      // users collection: email, createdAt, lastLoginAt
      // breaches collection: breachDate, addedDate, domain, pwnCount
      // search_results/{userId}/searches: searchDate, searchType, totalBreaches
      // notifications/{userId}/user_notifications: createdAt, read

      print('Database indexes should be created via Firebase Console');
    } catch (e) {
      print('Index creation note: $e');
    }
  }

  // Seed sample breach data
  Future<void> _seedSampleBreaches() async {
    try {
      // Check if breaches collection is empty
      QuerySnapshot breachesSnapshot = await _firestore.collection('breaches').limit(1).get();

      if (breachesSnapshot.docs.isEmpty) {
        List<Map<String, dynamic>> sampleBreaches = [
        {
          'name': 'Adobe',
    'title': 'Adobe',
    'domain': 'adobe.com',
    'breachDate': Timestamp.fromDate(DateTime(2013, 10, 4)),
    'addedDate': Timestamp.fromDate(DateTime(2013, 12, 4)),
    'modifiedDate': Timestamp.fromDate(DateTime(2022, 5, 15)),
    'pwnCount': 152445165,
    'description': 'In October 2013, 153 million Adobe accounts were breached with each containing an internal ID, username, email, encrypted password an