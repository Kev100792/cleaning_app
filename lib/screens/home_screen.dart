import 'package:flutter/material.dart';
import 'clients_screen.dart';
import 'contacts_screen.dart';
import 'entreprises_screen.dart';
import 'prestations_screen.dart';
import 'demandes_screen.dart';
import 'devis_screen.dart';
import 'factures_screen.dart';
import 'sites_screen.dart';
import 'activites_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRM Flutter")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        children: [
          _buildMenuButton(context, "Clients", ClientsScreen()),
          _buildMenuButton(context, "Contacts", ContactsScreen()),
          _buildMenuButton(context, "Entreprises", EntreprisesScreen()),
          _buildMenuButton(context, "Prestations", PrestationsScreen()),
          _buildMenuButton(context, "Demandes", DemandesScreen()),
          _buildMenuButton(context, "Devis", DevisScreen()),
          _buildMenuButton(context, "Factures", FacturesScreen()),
          _buildMenuButton(context, "Sites", SitesScreen()),
          _buildMenuButton(context, "Activités", ActivitesScreen()),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Widget screen) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
