import 'package:flutter/material.dart';
import '../models/demande.dart';
import '../database/db_helper.dart';

class DemandeProvider with ChangeNotifier {
  List<Demande> _demandes = [];

  List<Demande> get demandes => _demandes;

  Future<void> loadDemandes() async {
    _demandes = await DBHelper.getDemandes();
    notifyListeners();
  }

  Future<void> addDemande(Demande demande) async {
    await DBHelper.insertDemande(demande);
    await loadDemandes();
  }

  Future<void> deleteDemande(int id) async {
    await DBHelper.deleteDemande(id);
    await loadDemandes();
  }
}
