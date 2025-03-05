import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/facture_provider.dart';
import '../models/facture.dart';

class FacturesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Factures")),
      body: Center(child: Text("Factures Screen")),
    );
  }
}