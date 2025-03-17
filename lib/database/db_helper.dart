import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'dart:io';

import '../models/contact.dart';
import '../models/adresse.dart';
import '../models/entreprise.dart';
import '../models/activite.dart';
import '../models/demande.dart';
import '../models/devis.dart';
import '../models/facture.dart';
import '../models/site.dart';
import '../models/prestation.dart';


class DBHelper {
  static Database? _database;

    static Future<void> initDb() async {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
      } else if (Platform.isAndroid || Platform.isIOS) {
        databaseFactory = databaseFactory; // Utiliser la version standard pour Android/iOS
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

    
    if (_database != null) return;


    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'crm.db');

     _database = await databaseFactory.openDatabase(path, options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        print("Base de données créée avec succès !");
        await db.execute('''
          CREATE TABLE contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            entrepriseId INTEGER,
            nom TEXT,
            prenom TEXT,
            email TEXT,
            telephone TEXT,
            adresse TEXT,
            estClient INTEGER,
            dateCreation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE entreprises (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT,
            adresse TEXT,
            numeroTva TEXT,
            emailFacturation TEXT,
            emailContact TEXT,
            telephoneContact TEXT,
            dateCreation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE activites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            contactId INTEGER,
            entrepriseId INTEGER,
            description TEXT,
            date TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE demandes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            contactId INTEGER,
            entrepriseId INTEGER,
            siteId INTEGER,
            sujet TEXT,
            description TEXT,
            statut TEXT,
            dateCreation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE devis (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            demandeId INTEGER,
            entrepriseId INTEGER,
            dateValidite TEXT,
            dateCreation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE factures (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            entrepriseId INTEGER,
            dateCreation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE sites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            entrepriseId INTEGER,
            nom TEXT,
            type TEXT,
            adresse TEXT,
            acces TEXT,
            dateCreation TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE prestations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            siteId INTEGER,
            demandeId INTEGER,
            devisId INTEGER,
            factureId INTEGER,
            nom TEXT,
            description TEXT,
            prix REAL,
            dateDebut TEXT,
            heureDebut TEXT,
            dateFin TEXT,
            heureFin TEXT,
            dureeEstimee REAL,
            statut TEXT,
            responsableId INTEGER
          )
        ''');
      },
    ));
  }

  static Future<Database> database() async {
    if (_database == null) {
      await initDb();
    }
    return _database!;
  }

  // 🔹 Fonctions CRUD pour chaque entité 🔹

  // CONTACTS
  static Future<int> insertContact(Contact contact) async {
    final db = await database();
    return await db.insert('contacts', contact.toMap());
  }

  static Future<List<Contact>> getContacts() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) => Contact(
      id: maps[i]['id'],
      entrepriseId: maps[i]['entrepriseId'],
      nom: maps[i]['nom'],
      prenom: maps[i]['prenom'],
      email: maps[i]['email'],
      telephone: maps[i]['telephone'],
      adresse: Adresse(
        rue: '', numero: '', codePostal: '', ville: '',
      ), // TODO: Extraire adresse
      estClient: maps[i]['estClient'] == 1,
      dateCreation: DateTime.parse(maps[i]['dateCreation']),
    ));
  }

  static Future<void> deleteContact(int id) async {
    final db = await database();
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  // ENTREPRISES
  static Future<int> insertEntreprise(Entreprise entreprise) async {
  final db = await database();
  return await db.insert('entreprises', {
    'nom': entreprise.nom,
    'adresse': entreprise.adresse.toJson(),  // Convertir l'adresse en JSON
    'numeroTva': entreprise.numeroTva,
    'emailFacturation': entreprise.emailFacturation,
    'emailContact': entreprise.emailContact,
    'telephoneContact': entreprise.telephoneContact,
    'dateCreation': entreprise.dateCreation.toIso8601String(),
  });
}

static Future<List<Entreprise>> getEntreprises() async {
  final db = await database();
  final List<Map<String, dynamic>> maps = await db.query('entreprises');

  return List.generate(maps.length, (i) {
    return Entreprise(
      id: maps[i]['id'],
      nom: maps[i]['nom'],
      adresse: Adresse.fromJson(maps[i]['adresse']), // Convertir JSON en objet Adresse
      numeroTva: maps[i]['numeroTva'],
      emailFacturation: maps[i]['emailFacturation'],
      emailContact: maps[i]['emailContact'],
      telephoneContact: maps[i]['telephoneContact'],
      dateCreation: DateTime.parse(maps[i]['dateCreation']),
    );
  });
}

  static Future<void> deleteEntreprise(int id) async {
    final db = await database();
    await db.delete('entreprises', where: 'id = ?', whereArgs: [id]);
  }


  // PRESTATIONS
  static Future<int> insertPrestation(Prestation prestation) async {
    final db = await database();
    return await db.insert('prestations', prestation.toMap());
  }

  static Future<List<Prestation>> getPrestations() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('prestations');
    return List.generate(maps.length, (i) => Prestation(
      id: maps[i]['id'],
      siteId: maps[i]['siteId'],
      demandeId: maps[i]['demandeId'],
      devisId: maps[i]['devisId'],
      factureId: maps[i]['factureId'],
      nom: maps[i]['nom'],
      description: maps[i]['description'],
      prix: maps[i]['prix'],
      dateDebut: DateTime.parse(maps[i]['dateDebut']),
      heureDebut: maps[i]['heureDebut'],
      dateFin: DateTime.parse(maps[i]['dateFin']),
      heureFin: maps[i]['heureFin'],
      dureeEstimee: maps[i]['dureeEstimee'],
      statut: maps[i]['statut'],
      responsableId: maps[i]['responsableId'],
    ));
  }

  static Future<void> deletePrestation(int id) async {
    final db = await database();
    await db.delete('prestations', where: 'id = ?', whereArgs: [id]);
  }

  // ACTIVITES
  static Future<int> insertActivite(Activite activite) async {
    final db = await database();
    return await db.insert('activites', {
      'contactId': activite.contactId,
      'entrepriseId': activite.entrepriseId,
      'description': activite.description,
      'date': activite.date.toIso8601String(),
    });
  }

  static Future<List<Activite>> getActivites() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('activites');

    return List.generate(maps.length, (i) => Activite(
      id: maps[i]['id'],
      contactId: maps[i]['contactId'],
      entrepriseId: maps[i]['entrepriseId'],
      description: maps[i]['description'],
      date: DateTime.parse(maps[i]['date']),
    ));
  }

  static Future<void> deleteActivite(int id) async {
    final db = await database();
    await db.delete('activites', where: 'id = ?', whereArgs: [id]);
  }

  //DEMANDES
  static Future<int> insertDemande(Demande demande) async {
  final db = await database();
  return await db.insert('demandes', {
    'contactId': demande.contactId,
    'entrepriseId': demande.entrepriseId,
    'siteId': demande.siteId,
    'sujet': demande.sujet,
    'description': demande.description,
    'statut': demande.statut,
    'dateCreation': demande.dateCreation.toIso8601String(),
  });
}

static Future<List<Demande>> getDemandes() async {
  final db = await database();
  final List<Map<String, dynamic>> maps = await db.query('demandes');

  return List.generate(maps.length, (i) => Demande(
    id: maps[i]['id'],
    contactId: maps[i]['contactId'],
    entrepriseId: maps[i]['entrepriseId'],
    siteId: maps[i]['siteId'],
    sujet: maps[i]['sujet'],
    description: maps[i]['description'],
    statut: maps[i]['statut'],
    dateCreation: DateTime.parse(maps[i]['dateCreation']),
  ));
}

static Future<void> deleteDemande(int id) async {
  final db = await database();
  await db.delete('demandes', where: 'id = ?', whereArgs: [id]);
}

//DEVIS
static Future<int> insertDevis(Devis devis) async {
  final db = await database();
  return await db.insert('devis', {
    'demandeId': devis.demandeId,
    'entrepriseId': devis.entrepriseId,
    'dateValidite': devis.dateValidite.toIso8601String(),
    'dateCreation': devis.dateCreation.toIso8601String(),
  });
}

static Future<List<Devis>> getDevis() async {
  final db = await database();
  final List<Map<String, dynamic>> maps = await db.query('devis');

  return List.generate(maps.length, (i) => Devis(
    id: maps[i]['id'],
    demandeId: maps[i]['demandeId'],
    entrepriseId: maps[i]['entrepriseId'],
    dateValidite: DateTime.parse(maps[i]['dateValidite']),
    dateCreation: DateTime.parse(maps[i]['dateCreation']),
  ));
}

static Future<void> deleteDevis(int id) async {
  final db = await database();
  await db.delete('devis', where: 'id = ?', whereArgs: [id]);
}

//FACTURES
static Future<int> insertFacture(Facture facture) async {
  final db = await database();
  return await db.insert('factures', {
    'entrepriseId': facture.entrepriseId,
    'dateCreation': facture.dateCreation.toIso8601String(),
  });
}

static Future<List<Facture>> getFactures() async {
  final db = await database();
  final List<Map<String, dynamic>> maps = await db.query('factures');

  return List.generate(maps.length, (i) => Facture(
    id: maps[i]['id'],
    entrepriseId: maps[i]['entrepriseId'],
    dateCreation: DateTime.parse(maps[i]['dateCreation']),
  ));
}

static Future<void> deleteFacture(int id) async {
  final db = await database();
  await db.delete('factures', where: 'id = ?', whereArgs: [id]);
}

//SITES
static Future<int> insertSite(Site site) async {
  final db = await database();
  return await db.insert('sites', {
    'entrepriseId': site.entrepriseId,
    'nom': site.nom,
    'type': site.type,
    'adresse': site.adresse.toJson(),  // Convertir en JSON
    'acces': site.acces,
    'dateCreation': site.dateCreation.toIso8601String(),
  });
}

static Future<List<Site>> getSites() async {
  final db = await database();
  final List<Map<String, dynamic>> maps = await db.query('sites');

  return List.generate(maps.length, (i) => Site(
    id: maps[i]['id'],
    entrepriseId: maps[i]['entrepriseId'],
    nom: maps[i]['nom'],
    type: maps[i]['type'],
    adresse: Adresse.fromJson(maps[i]['adresse']), // Convertir JSON en objet Adresse
    acces: maps[i]['acces'],
    dateCreation: DateTime.parse(maps[i]['dateCreation']),
  ));
}

static Future<void> deleteSite(int id) async {
  final db = await database();
  await db.delete('sites', where: 'id = ?', whereArgs: [id]);
}


}