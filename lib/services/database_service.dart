import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // =============================================================================
  // USER OPERATIONS
  // =============================================================================

  // Create user document
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toFirestore());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Get user by ID
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, uid);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  // Update user
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Update user last login
  Future<void> updateLastLogin(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update last login: $e');
    }
  }

  // Add to search history
  Future<void> addToSearchHistory(String uid, String searchTerm) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'searchHistory': FieldValue.arrayUnion([searchTerm]),
      });
    } catch (e) {
      throw Exception('Failed to add to search history: $e');
    }
  }

  // =============================================================================
  // BREACH OPERATIONS
  // =============================================================================

  // Add breach (Admin only)
  Future<void> addBreach(BreachModel breach) async {
    try {
      await _firestore.collection('breaches').doc(breach.name).set(breach.toFirestore());
    } catch (e) {
      throw Exception('Failed to add breach: $e');
    }
  }

  // Get all breaches
  Future<List<BreachModel>> getAllBreaches() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('breaches')
          .orderBy('breachDate', descending: true)
          .get();

      return snapshot.docs.map((doc) =>
          BreachModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)
      ).toList();
    } catch (e) {
      throw Exception('Failed to get breaches: $e');
    }
  }

  // Search breaches by email
  Future<List<BreachModel>> searchBreachesByEmail(String email) async {
    try {
      // This would typically connect to HaveIBeenPwned API
      // For now, we'll search local breach database
      QuerySnapshot snapshot = await _firestore
          .collection('breaches')
          .where('affectedEmails', arrayContains: email.toLowerCase())
          .get();

      return snapshot.docs.map((doc) =>
          BreachModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)
      ).toList();
    } catch (e) {
      throw Exception('Failed to search breaches: $e');
    }
  }

  // Get breach by name
  Future<BreachModel?> getBreachByName(String name) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('breaches').doc(name).get();
      if (doc.exists) {
        return BreachModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get breach: $e');
    }
  }

  // =============================================================================
  // SEARCH RESULT OPERATIONS
  // =============================================================================

  // Save search result
  Future<void> saveSearchResult(SearchResultModel searchResult) async {
    try {
      await _firestore
          .collection('search_results')
          .doc(searchResult.userId)
          .collection('searches')
          .add(searchResult.toFirestore());
    } catch (e) {
      throw Exception('Failed to save search result: $e');
    }
  }

  // Get user search history
  Future<List<SearchResultModel>> getUserSearchHistory(String userId, {int limit = 20}) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('search_results')
          .doc(userId)
          .collection('searches')
          .orderBy('searchDate', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) =>
          SearchResultModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)
      ).toList();
    } catch (e) {
      throw Exception('Failed to get search history: $e');
    }
  }

  // Get search statistics
  Future<Map<String, dynamic>> getSearchStatistics(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('search_results')
          .doc(userId)
          .collection('searches')
          .get();

      int totalSearches = snapshot.docs.length;
      int totalBreachesFound = 0;

      for (var doc in snapshot.docs) {
        SearchResultModel result = SearchResultModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
        totalBreachesFound += result.totalBreaches;
      }

      return {
        'totalSearches': totalSearches,
        'totalBreachesFound': totalBreachesFound,
        'lastSearchDate': snapshot.docs.isNotEmpty
            ? (snapshot.docs.first.data() as Map<String, dynamic>)['searchDate']
            : null,
      };
    } catch (e) {
      throw Exception('Failed to get search statistics: $e');
    }
  }

  // =============================================================================
  // NOTIFICATIONS & ALERTS
  // =============================================================================

  // Save notification
  Future<void> saveNotification(String userId, Map<String, dynamic> notification) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('user_notifications')
          .add({
        ...notification,
        'createdAt': FieldValue.serverTimestamp(),
        'read': false,
      });
    } catch (e) {
      throw Exception('Failed to save notification: $e');
    }
  }

  // Get user notifications
  Future<List<Map<String, dynamic>>> getUserNotifications(String userId, {int limit = 50}) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('user_notifications')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      }).toList();
    } catch (e) {
      throw Exception('Failed to get notifications: $e');
    }
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String userId, String notificationId) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('user_notifications')
          .doc(notificationId)
          .update({'read': true});
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  // =============================================================================
  // ADMIN OPERATIONS
  // =============================================================================

  // Get all users (Admin only)
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) =>
          UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)
      ).toList();
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  // Get platform statistics (Admin only)
  Future<Map<String, dynamic>> getPlatformStatistics() async {
    try {
      // Get total users
      QuerySnapshot usersSnapshot = await _firestore.collection('users').get();
      int totalUsers = usersSnapshot.docs.length;

      // Get total breaches
      QuerySnapshot breachesSnapshot = await _firestore.collection('breaches').get();
      int totalBreaches = breachesSnapshot.docs.length;

      // Get total searches
      QuerySnapshot searchesSnapshot = await _firestore.collectionGroup('searches').get();
      int totalSearches = searchesSnapshot.docs.length;

      return {
        'totalUsers': totalUsers,
        'totalBreaches': totalBreaches,
        'totalSearches': totalSearches,
        'lastUpdated': FieldValue.serverTimestamp(),
      };
    } catch (e) {
      throw Exception('Failed to get platform statistics: $e');
    }
  }
}

// =============================================================================
// REALTIME DATABASE SERVICE (for real-time updates)
// =============================================================================

// lib/services/realtime_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class RealtimeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Listen to user data changes
  Stream<UserModel?> getUserStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromFirestore(snapshot.data()!, uid);
      }
      return null;
    });
  }

  // Listen to search results changes
  Stream<List<SearchResultModel>> getSearchResultsStream(String userId) {
    return _firestore
        .collection('search_results')
        .doc(userId)
        .collection('searches')
        .orderBy('searchDate', descending: true)
        .limit(20)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) =>
          SearchResultModel.fromFirestore(doc.data(), doc.id)
      ).toList();
    });
  }

  // Listen to notifications
  Stream<List<Map<String, dynamic>>> getNotificationsStream(String userId) {
    return _firestore
        .collection('notifications')
        .doc(userId)
        .collection('user_notifications')
        .where('read', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    });
  }

  // Listen to breach updates
  Stream<List<BreachModel>> getBreachesStream() {
    return _firestore
        .collection('breaches')
        .orderBy('addedDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) =>
          BreachModel.fromFirestore(doc.data(), doc.id)
      ).toList();
    });
  }
}