import 'package:flutter/material.dart';
import '../models/site.dart';
import '../database/db_helper.dart';

class ChantierProvider with ChangeNotifier {
  List<Site> _sites = [];

  List<Site> get sites => _sites;

  Future<void> loadSites() async {
    _sites = await DBHelper.getSites();
    notifyListeners();
  }

  Future<void> addSite(Site site) async {
    await DBHelper.insertSite(site);
    await loadSites();
  }

  Future<void> deleteSite(int id) async {
    await DBHelper.deleteSite(id);
    await loadSites();
  }
}
