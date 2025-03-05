import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';
import '../models/contact.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Clients")),
      body: FutureBuilder(
        future: clientProvider.loadClients(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: clientProvider.clients.length,
            itemBuilder: (ctx, i) {
              final client = clientProvider.clients[i];
              return ListTile(
                title: Text("${client.nom} ${client.prenom}"),
                subtitle: Text(client.email),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => clientProvider.deleteClient(client.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO: Ajouter l'écran pour ajouter un client
        },
      ),
    );
  }
}
