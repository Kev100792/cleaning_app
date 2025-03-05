class Facture {
  int? id;
  int entrepriseId;
  DateTime dateCreation;

  Facture({
    this.id,
    required this.entrepriseId,
    required this.dateCreation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'entrepriseId': entrepriseId,
      'dateCreation': dateCreation.toIso8601String(),
    };
  }
}
