import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prestation_provider.dart';
import '../models/prestation.dart';

class PrestationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prestationProvider = Provider.of<PrestationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Prestations")),
      body: FutureBuilder(
        future: prestationProvider.loadPrestations(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: prestationProvider.prestations.length,
            itemBuilder: (ctx, i) {
              final prestation = prestationProvider.prestations[i];
              return ListTile(
                title: Text(prestation.nom),
                subtitle: Text("${prestation.prix} €"),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => prestationProvider.deletePrestation(prestation.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO: Ajouter l'écran pour ajouter une prestation
        },
      ),
    );
  }
}
