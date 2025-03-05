import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../database/db_helper.dart';

class ClientProvider with ChangeNotifier {
  List<Contact> _clients = [];

  List<Contact> get clients => _clients;

  Future<void> loadClients() async {
    _clients = await DBHelper.getContacts();
    notifyListeners();
  }

  Future<void> addClient(Contact client) async {
    await DBHelper.insertContact(client);
    await loadClients();
  }

  Future<void> deleteClient(int id) async {
    await DBHelper.deleteContact(id);
    await loadClients();
  }
}
