import "package:path/path.dart";
import "package:totalbloc/features/pdebug.dart";
//import "package:totalbloc/models/todo.dart";

import "package:sqflite/sqflite.dart";
import "package:sqflite_common/sqflite_logger.dart";

// this is the place where to create all tables in first database run

class MainDbHelper {
  Future<Database> initializeDB() async {
    pd("lotteries_repo_local.dart, initializeDB()");
    String path = await getDatabasesPath();

    // SQFLITE ENABLE LOGGING ->
    var factoryWithLogs = SqfliteDatabaseFactoryLogger(databaseFactory,
        options:
            SqfliteLoggerOptions(type: SqfliteDatabaseFactoryLoggerType.all));
    return factoryWithLogs.openDatabase(join(path, "database.db"),
        options: OpenDatabaseOptions(
          onCreate: (db, version) async {
            await _onCreate(db, 1);
          },
          version: 1,
        ));
    // SQFLITE ENABLE LOGGING ->

    // below is the place to disable Database loggin (sqflite),
    // just comment above return statement and uncomment below return statement
    // to disable logging and increased performance after making sure CRUD operations work
    // without any problems and errors
    //
    // return openDatabase(
    //   join(path, "database.db"),
    //   onCreate: (db, version) async {
    //     await _onCreate(db, 1);
    //   },
    //   version: 1,
    // );
  }

  _onCreate(Database db, int version) async {
    pd("lotteries_repo_local.dart, _onCreate()");
    for (String query in sqfliteTables) {
      await db.execute(query);
    }
  }

  // this is for try/catch on isNoSuchTableError error
  onCreateForTryCatch() async {
    for (String query in sqfliteTables) {
      Database db = await initializeDB();
      await db.execute(query);
    }
  }
}

final List<String> sqfliteTables = [
  '''
CREATE TABLE Todo(
  todoId INTEGER AUTO INCREMENT PRIMARY KEY,
  todoUuid TEXT,
  todoName TEXT,
  todoDescription TEXT,
  todoFav INTEGER
)
''',
  '''
CREATE TABLE DummyTable(
  settingId INTEGER AUTO INCREMENT PRIMARY KEY,
  settingName TEXT,
  settingData TEXT
)
''',
];

// the dummy table is not used
// added to show how to create multiple (all tables necessary for the app) tables 
