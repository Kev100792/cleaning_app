import 'package:flutter/material.dart';
import '../models/entreprise.dart';
import '../database/db_helper.dart';

class EntrepriseProvider with ChangeNotifier {
  List<Entreprise> _entreprises = [];

  List<Entreprise> get entreprises => _entreprises;

  Future<void> loadEntreprises() async {
    _entreprises = await DBHelper.getEntreprises();
    notifyListeners();
  }

  Future<void> addEntreprise(Entreprise entreprise) async {
    await DBHelper.insertEntreprise(entreprise);
    await loadEntreprises();
  }

  Future<void> deleteEntreprise(int id) async {
    await DBHelper.deleteEntreprise(id);
    await loadEntreprises();
  }
}
