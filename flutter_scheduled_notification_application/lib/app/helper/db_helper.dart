import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/medicine.dart';

class DbHelper {
  static const _databaseName = "medicine.db";
  static const _databaseVersion = 1;

  static const tableName = "medicine";

  static const columnId = 'id';
  static const columnJudul = 'judul';
  static const columnDeskripsi = 'deskripsi';
  static const columnIsDone = 'isDone';

  Database? _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
		  CREATE TABLE $tableName (
		    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
		    $columnJudul TEXT NOT NULL,
		    $columnDeskripsi TEXT NOT NULL,
		    $columnIsDone INTEGER NOT NULL
		  )
	  ''');
  }

  Future<void> insertMedicine(Medicine medicine) async {
    final db = await database;
    await db.insert(
      tableName,
      medicine.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Medicine>> queryAllRows() async {
    final db = await database;

    List<Map<String, dynamic>> medicines =
        await db.query(tableName, orderBy: "$columnId DESC");
    return List.generate(
        medicines.length,
        (index) => Medicine(
              id: medicines[index]['id'],
              name: medicines[index]['name'],
              frequency: medicines[index]['frequency']
            ));
  }

  Future<void> deleteMedicine(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: '$columnId == ?',
      whereArgs: [id],
    );
  }

  Future<void> isCheckedMedicine(int id, bool value) async {
    final db = await database;
    Map<String, dynamic> newMedicine = {columnIsDone: value};
    await db.update(
      tableName,
      newMedicine,
      where: '$columnId == ?',
      whereArgs: [id],
    );
  }
}
