class Prestation {
  int? id;
  int siteId;
  int demandeId;
  int devisId;
  int factureId;
  String nom;
  String description;
  double prix;
  DateTime dateDebut;
  String heureDebut;
  DateTime dateFin;
  String heureFin;
  double dureeEstimee;
  String statut;
  int responsableId;

  Prestation({
    this.id,
    required this.siteId,
    required this.demandeId,
    required this.devisId,
    required this.factureId,
    required this.nom,
    required this.description,
    required this.prix,
    required this.dateDebut,
    required this.heureDebut,
    required this.dateFin,
    required this.heureFin,
    required this.dureeEstimee,
    required this.statut,
    required this.responsableId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siteId': siteId,
      'demandeId': demandeId,
      'devisId': devisId,
      'factureId': factureId,
      'nom': nom,
      'description': description,
      'prix': prix,
      'dateDebut': dateDebut.toIso8601String(),
      'heureDebut': heureDebut,
      'dateFin': dateFin.toIso8601String(),
      'heureFin': heureFin,
      'dureeEstimee': dureeEstimee,
      'statut': statut,
      'responsableId': responsableId,
    };
  }
}
