import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/site_provider.dart';
import '../models/site.dart';

class SitesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sites")),
      body: Center(child: Text("Sites Screen")),
    );
  }
}