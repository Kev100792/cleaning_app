import 'package:flutter/material.dart';
import '../models/facture.dart';
import '../database/db_helper.dart';

class FactureProvider with ChangeNotifier {
  List<Facture> _factures = [];

  List<Facture> get factures => _factures;

  Future<void> loadFactures() async {
    _factures = await DBHelper.getFactures();
    notifyListeners();
  }

  Future<void> addFacture(Facture facture) async {
    await DBHelper.insertFacture(facture);
    await loadFactures();
  }

  Future<void> deleteFacture(int id) async {
    await DBHelper.deleteFacture(id);
    await loadFactures();
  }
}
