import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activite_provider.dart';
import '../models/activite.dart';

class ActivitesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Activités")),
      body: Center(child: Text("Activités Screen")),
    );
  }
}