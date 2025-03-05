class Activite {
  int? id;
  int contactId;
  int entrepriseId;
  String description;
  DateTime date;

  Activite({
    this.id,
    required this.contactId,
    required this.entrepriseId,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contactId': contactId,
      'entrepriseId': entrepriseId,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}
