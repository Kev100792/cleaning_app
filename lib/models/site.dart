import 'adresse.dart';

class Site {
  int? id;
  int entrepriseId;
  String nom;
  String type;
  Adresse adresse;
  String acces;
  DateTime dateCreation;

  Site({
    this.id,
    required this.entrepriseId,
    required this.nom,
    required this.type,
    required this.adresse,
    required this.acces,
    required this.dateCreation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'entrepriseId': entrepriseId,
      'nom': nom,
      'type': type,
      'adresse': adresse.toMap(),
      'acces': acces,
      'dateCreation': dateCreation.toIso8601String(),
    };
  }
}
