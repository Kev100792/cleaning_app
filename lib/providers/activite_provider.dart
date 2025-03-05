import 'package:flutter/material.dart';
import '../models/activite.dart';
import '../database/db_helper.dart';

class ActiviteProvider with ChangeNotifier {
  List<Activite> _activites = [];

  List<Activite> get activites => _activites;

  Future<void> loadActivites() async {
    _activites = await DBHelper.getActivites();
    notifyListeners();
  }

  Future<void> addActivite(Activite activite) async {
    await DBHelper.insertActivite(activite);
    await loadActivites();
  }

  Future<void> deleteActivite(int id) async {
    await DBHelper.deleteActivite(id);
    await loadActivites();
  }
}
