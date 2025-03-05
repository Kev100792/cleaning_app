import 'package:flutter/material.dart';
import '../models/devis.dart';
import '../database/db_helper.dart';

class DevisProvider with ChangeNotifier {
  List<Devis> _devis = [];

  List<Devis> get devis => _devis;

  Future<void> loadDevis() async {
    _devis = await DBHelper.getDevis();
    notifyListeners();
  }

  Future<void> addDevis(Devis devis) async {
    await DBHelper.insertDevis(devis);
    await loadDevis();
  }

  Future<void> deleteDevis(int id) async {
    await DBHelper.deleteDevis(id);
    await loadDevis();
  }
}
