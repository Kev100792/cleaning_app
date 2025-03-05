import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/devis_provider.dart';
import '../models/devis.dart';

class DevisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Devis")),
      body: Center(child: Text("Devis Screen")),
    );
  }
}