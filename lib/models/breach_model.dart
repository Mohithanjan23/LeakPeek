class BreachModel {
  final String id;
  final String name;
  final String title;
  final String domain;
  final DateTime breachDate;
  final DateTime addedDate;
  final DateTime modifiedDate;
  final int pwnCount;
  final String description;
  final List<String> dataClasses;
  final bool isVerified;
  final bool isFabricated;
  final bool isSensitive;
  final bool isRetired;
  final bool isSpamList;
  final String logoPath;

  BreachModel({
    required this.id,
    required this.name,
    required this.title,
    required this.domain,
    required this.breachDate,
    required this.addedDate,
    required this.modifiedDate,
    required this.pwnCount,
    required this.description,
    required this.dataClasses,
    required this.isVerified,
    required this.isFabricated,
    required this.isSensitive,
    required this.isRetired,
    required this.isSpamList,
    required this.logoPath,
  });

  factory BreachModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BreachModel(
      id: id,
      name: data['name'] ?? '',
      title: data['title'] ?? '',
      domain: data['domain'] ?? '',
      breachDate:
          (data['breachDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      addedDate: (data['addedDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      modifiedDate:
          (data['modifiedDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      pwnCount: data['pwnCount'] ?? 0,
      description: data['description'] ?? '',
      dataClasses: List<String>.from(data['dataClasses'] ?? []),
      isVerified: data['isVerified'] ?? false,
      isFabricated: data['isFabricated'] ?? false,
      isSensitive: data['isSensitive'] ?? false,
      isRetired: data['isRetired'] ?? false,
      isSpamList: data['isSpamList'] ?? false,
      logoPath: data['logoPath'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'title': title,
      'domain': domain,
      'breachDate': Timestamp.fromDate(breachDate),
      'addedDate': Timestamp.fromDate(addedDate),
      'modifiedDate': Timestamp.fromDate(modifiedDate),
      'pwnCount': pwnCount,
      'description': description,
      'dataClasses': dataClasses,
      'isVerified': isVerified,
      'isFabricated': isFabricated,
      'isSensitive': isSensitive,
      'isRetired': isRetired,
      'isSpamList': isSpamList,
      'logoPath': logoPath,
    };
  }
}
