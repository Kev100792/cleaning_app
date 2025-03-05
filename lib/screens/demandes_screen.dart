import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/demande_provider.dart';
import '../models/demande.dart';

class DemandesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demandes")),
      body: Center(child: Text("Demandes Screen")),
    );
  }
}