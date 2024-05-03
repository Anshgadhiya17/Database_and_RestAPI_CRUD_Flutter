import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'userDatabase.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "userDatabase.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'userDatabase.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }
  Future<List<Map<String,dynamic>>> getDetails() async {
    Database db=await initDatabase();
    List<Map<String,dynamic>> userList= await db.rawQuery('select * from Tbl_User');
    return userList;
  }

  Future<Map<String,dynamic>> getDetailsById(int id) async {
    Database db=await initDatabase();
    List<Map<String,dynamic>> userList= await db.rawQuery('select * from Tbl_User where UserId=$id');
    return userList[0];
  }

  Future<void> deleteById(int id) async {
    Database db=await initDatabase();
    var res=await db.delete('Tbl_User',where: 'UserId=?',whereArgs:[id]);
  }

  Future<int> insertUser(Map<String,dynamic> map) async {
    Database db=await initDatabase();
    var res=await db.insert('Tbl_User', map);
    return res;
  }
  Future<int> UpdateUser(Map<String,dynamic> map,int id) async {
    Database db=await initDatabase();
    var res=await db.update('Tbl_User', map,where: 'UserId=?',whereArgs: [id]);
    return res;
  }
}