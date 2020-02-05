import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Me {
  final int id;
  final String firstAndLastName, birthday, email, password;
  final bool isLoggedIn;

  Me({
    this.id,
    this.firstAndLastName,
    this.birthday,
    this.email,
    this.password,
    this.isLoggedIn,
  });
}

class Reports {
  final int id, uId;
  final date, startDate, endDate, text;
  final double hours;
  final bool deleted;
  final int yearOfTraining;

  Reports({
    this.id,
    this.uId,
    this.date,
    this.startDate,
    this.endDate,
    this.text,
    this.hours,
    this.deleted,
    this.yearOfTraining,
  });
}

class Trainees {
  final int id, u_id;
  final int typeTraining;
  final String startDate, endDate;

  Trainees({
    this.id,
    this.u_id,
    this.typeTraining,
    this.startDate,
    this.endDate,
  });
}

class SqfLite {
  Future<Database> database() async => openDatabase(
        join(await getDatabasesPath(), 'r_a_db.db'),
        onCreate: (db, version) {
          return db.execute("");
        },
        version: 1,
      );
}
