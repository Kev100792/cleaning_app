import 'dart:convert';

class Adresse {
  String rue;
  String numero;
  String codePostal;
  String ville;

  Adresse({required this.rue, required this.numero, required this.codePostal, required this.ville});

  // Convertir l'objet en JSON pour SQLite
  String toJson() => jsonEncode(toMap());

  // Convertir JSON en objet Adresse
  factory Adresse.fromJson(String json) {
    final data = jsonDecode(json);
    return Adresse(
      rue: data['rue'],
      numero: data['numero'],
      codePostal: data['code_postal'],
      ville: data['ville'],
    );
  }

  // ✅ Ajout de la méthode toMap() pour assurer la compatibilité
  Map<String, dynamic> toMap() {
    return {
      'rue': rue,
      'numero': numero,
      'code_postal': codePostal,
      'ville': ville,
    };
  }
}
