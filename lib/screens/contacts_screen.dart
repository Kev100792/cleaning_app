import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contact_provider.dart';
import '../models/contact.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Center(child: Text("Contacts Screen")),
    );
  }
}