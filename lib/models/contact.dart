import 'adresse.dart';

class Contact {
  int? id;
  int? entrepriseId;
  String nom;
  String prenom;
  String email;
  String telephone;
  Adresse adresse;
  bool estClient;
  DateTime dateCreation;

  Contact({
    this.id,
    this.entrepriseId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.estClient,
    required this.dateCreation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'entrepriseId': entrepriseId,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse.toMap(),
      'estClient': estClient ? 1 : 0,
      'dateCreation': dateCreation.toIso8601String(),
    };
  }
}
