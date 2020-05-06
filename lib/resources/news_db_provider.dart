import 'dart:io';

import 'package:news/models/item_model.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    db = await openDatabase(
        // Set the path to the database.
        join(await getDatabasesPath(), "items5.db"),
        version: 1,
        // When the database is first created, create a table to store dogs.
        onCreate: (Database newDb, int version) {
      // Run the CREATE TABLE statement on the database.
      newDb.execute("""

      CREATE TABLE Items5(
              id INTEGER PRIMARY KEY,
              deleted INTEGER,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              dead INTEGER,
              parent INTEGER,
              kids BLOB,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTERGER
            )
    """);
    });

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    // Directory documentDerectory = await getApplicationDocumentsDirectory();
    // final path = join(documentDerectory.path, "items.db");

    // db = await openDatabase(
    //   path,
    //   version: 1,
    //   onCreate: (Database newDb, int version) {
    //     newDb.execute("""
    //         CREATE TABLE items(
    //           id INTEGER PRIMARY KEY,
    //           deleted INTEGER,
    //           type TEXT,
    //           by TEXT,
    //           time INTEGER,
    //           text TEXT,
    //           dead INTEGER,
    //           parent INTEGER,
    //           kids BLOB,
    //           url TEXT,
    //           score INTEGER,
    //           title TEXT,
    //           descendants INTERGER
    //         )
    //       """);
    //   },
    // );
  }

  //(todo)- store and fetch top Ids
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<ItemModels> fetchItems(int id) async {
    final map = await db.query(
      "items5",
      columns: null,
      // distinct: true,
      where: "id =?",
      whereArgs: [id],
    );

    if (map.length > 0) {
      return ItemModels.fromDb(map.first);
    }
    return null;
  }

  // here async is absent because we do not need to wait for the operation
  // or we don't need this to do next job...
  Future<int> addItems(ItemModels items) {
    return db.insert(
      "items5",
      items.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

 Future<int> clear() async {
    return await db.delete("items5");
  }
}

final NewsDbProvider newsDbProvider = NewsDbProvider();
