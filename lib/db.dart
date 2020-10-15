import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  Db._();

  static final Db db = Db._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await Init();
    return _database;
  }

  Init() async {
    return await openDatabase(join(await getDatabasesPath(), 'mydb.db'),
        version: 1,
        onCreate: (db, v) async {
      await db.execute('''CREATE TABLE user (
          user_ID INTEGER PRIMARY KEY,
          user_Name varchar(45),
          user_Email varchar(45),
          user_Gender varchar(45),
          user_Hieght INTEGER,
          user_Weigth INTEGER,
          user_Age INTEGER,
          user_Pass varchar(45),
          date_Of_Birth datetime,
          BMI INTEGER,
          total_Of_Calorie INTEGER
          )''');
    });
  }

  InserNew(user) async {
    final db = await database;
    var rng = new Random();
    var id = rng.nextInt(100);
    print(
        '''Insert into user values($id,'${user.uname}','${user.email}','${user.gender}',${user.he},${user.we},${user.age},${user.pass},'${user.date}',${user.BMI},${user.total_Of_Calorie})''');
    var res = await db.rawInsert(
        '''Insert into user values($id,'${user.uname}','${user.email}','${user.gender}',${user.he},${user.we},${user.age},${user.pass},'${user.date}',${user.BMI},${user.total_Of_Calorie})''');
    return res;
  }
  login(String UserName,int Pass) async {
    final db = await database;
    var res =await  db.query("user", where: "user_Name = ? and user_Pass= ?", whereArgs: [UserName,Pass]);
    return res.isNotEmpty ? true : false ;
  }
}
