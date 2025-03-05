class Demande {
  int? id;
  int contactId;
  int entrepriseId;
  int siteId;
  String sujet;
  String description;
  String statut;
  DateTime dateCreation;

  Demande({
    this.id,
    required this.contactId,
    required this.entrepriseId,
    required this.siteId,
    required this.sujet,
    required this.description,
    required this.statut,
    required this.dateCreation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contactId': contactId,
      'entrepriseId': entrepriseId,
      'siteId': siteId,
      'sujet': sujet,
      'description': description,
      'statut': statut,
      'dateCreation': dateCreation.toIso8601String(),
    };
  }
}
