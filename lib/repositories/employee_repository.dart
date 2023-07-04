import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/employee.dart';

class EmployeeRepository {
  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'employees.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE employees(
            employeeId TEXT PRIMARY KEY,
            employeeName TEXT,
            employeeDesignation TEXT,
            employeeJoiningDate TEXT,
            employeeLeavingDate TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> deleteDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'employees.db');
    return deleteDatabase(path);
  }

  Future<List<Employee>> getEmployees() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> maps = await db.query('employees');

    return List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
  }

  Future<void> insertEmployee(Employee employee) async {
    final db = await _openDatabase();

    await db.insert(
      'employees',
      employee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEmployee(Employee employee) async {
    final db = await _openDatabase();

    await db.update(
      'employees',
      employee.toMap(),
      where: 'employeeId = ?',
      whereArgs: [employee.employeeId],
    );
  }

  Future<void> deleteEmployee(String employeeId) async {
    final db = await _openDatabase();

    await db.delete(
      'employees',
      where: 'employeeId = ?',
      whereArgs: [employeeId],
    );
  }

}
