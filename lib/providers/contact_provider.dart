import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../database/db_helper.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    _contacts = await DBHelper.getContacts();
    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    await DBHelper.insertContact(contact);
    await loadContacts();
  }

  Future<void> deleteContact(int id) async {
    await DBHelper.deleteContact(id);
    await loadContacts();
  }
}
