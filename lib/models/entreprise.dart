import 'adresse.dart';

class Entreprise {
  int? id;
  String nom;
  Adresse adresse;
  String numeroTva;
  String emailFacturation;
  String emailContact;
  String telephoneContact;
  DateTime dateCreation;

  Entreprise({
    this.id,
    required this.nom,
    required this.adresse,
    required this.numeroTva,
    required this.emailFacturation,
    required this.emailContact,
    required this.telephoneContact,
    required this.dateCreation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'adresse': adresse.toMap(),
      'numeroTva': numeroTva,
      'emailFacturation': emailFacturation,
      'emailContact': emailContact,
      'telephoneContact': telephoneContact,
      'dateCreation': dateCreation.toIso8601String(),
    };
  }
}
