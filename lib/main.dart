import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/client_provider.dart';
import 'providers/contact_provider.dart';
import 'providers/entreprise_provider.dart';
import 'providers/activite_provider.dart';
import 'providers/chantier_provider.dart';
import 'providers/prestation_provider.dart';
import 'providers/demande_provider.dart';
import 'providers/devis_provider.dart';
import 'providers/facture_provider.dart';
import 'providers/site_provider.dart';
import 'database/db_helper.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClientProvider()),
        ChangeNotifierProvider(create: (context) => ContactProvider()),
        ChangeNotifierProvider(create: (context) => EntrepriseProvider()),
        ChangeNotifierProvider(create: (context) => ActiviteProvider()),
        ChangeNotifierProvider(create: (context) => ChantierProvider()),
        ChangeNotifierProvider(create: (context) => PrestationProvider()),
        ChangeNotifierProvider(create: (context) => DemandeProvider()),
        ChangeNotifierProvider(create: (context) => DevisProvider()),
        ChangeNotifierProvider(create: (context) => FactureProvider()),
        ChangeNotifierProvider(create: (context) => SiteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRM Flutter',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}