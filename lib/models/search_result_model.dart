class SearchResultModel {
  final String id;
  final String userId;
  final String searchTerm;
  final String searchType; // 'email', 'username', 'phone'
  final List<String> breachesFound;
  final int totalBreaches;
  final DateTime searchDate;
  final bool isPwnCount;
  final Map<String, dynamic> metadata;

  SearchResultModel({
    required this.id,
    required this.userId,
    required this.searchTerm,
    required this.searchType,
    required this.breachesFound,
    required this.totalBreaches,
    required this.searchDate,
    required this.isPwnCount,
    required this.metadata,
  });

  factory SearchResultModel.fromFirestore(
      Map<String, dynamic> data, String id) {
    return SearchResultModel(
      id: id,
      userId: data['userId'] ?? '',
      searchTerm: data['searchTerm'] ?? '',
      searchType: data['searchType'] ?? 'email',
      breachesFound: List<String>.from(data['breachesFound'] ?? []),
      totalBreaches: data['totalBreaches'] ?? 0,
      searchDate:
          (data['searchDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isPwnCount: data['isPwnCount'] ?? false,
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'searchTerm': searchTerm,
      'searchType': searchType,
      'breachesFound': breachesFound,
      'totalBreaches': totalBreaches,
      'searchDate': Timestamp.fromDate(searchDate),
      'isPwnCount': isPwnCount,
      'metadata': metadata,
    };
  }
}
