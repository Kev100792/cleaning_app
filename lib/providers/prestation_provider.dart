import 'package:flutter/material.dart';
import '../models/prestation.dart';
import '../database/db_helper.dart';

class PrestationProvider with ChangeNotifier {
  List<Prestation> _prestations = [];

  List<Prestation> get prestations => _prestations;

  Future<void> loadPrestations() async {
    _prestations = await DBHelper.getPrestations();
    notifyListeners();
  }

  Future<void> addPrestation(Prestation prestation) async {
    await DBHelper.insertPrestation(prestation);
    await loadPrestations();
  }

  Future<void> deletePrestation(int id) async {
    await DBHelper.deletePrestation(id);
    await loadPrestations();
  }
}
