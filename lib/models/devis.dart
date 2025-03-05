class Devis {
  int? id;
  int demandeId;
  int entrepriseId;
  DateTime dateValidite;
  DateTime dateCreation;

  Devis({
    this.id,
    required this.demandeId,
    required this.entrepriseId,
    required this.dateValidite,
    required this.dateCreation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'demandeId': demandeId,
      'entrepriseId': entrepriseId,
      'dateValidite': dateValidite.toIso8601String(),
      'dateCreation': dateCreation.toIso8601String(),
    };
  }
}
