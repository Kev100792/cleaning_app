import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/entreprise_provider.dart';
import '../models/entreprise.dart';

class EntreprisesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entrepriseProvider = Provider.of<EntrepriseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Entreprises")),
      body: FutureBuilder(
        future: entrepriseProvider.loadEntreprises(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: entrepriseProvider.entreprises.length,
            itemBuilder: (ctx, i) {
              final entreprise = entrepriseProvider.entreprises[i];
              return ListTile(
                title: Text(entreprise.nom),
                subtitle: Text(entreprise.emailContact),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => entrepriseProvider.deleteEntreprise(entreprise.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO: Ajouter l'écran pour ajouter une entreprise
        },
      ),
    );
  }
}
