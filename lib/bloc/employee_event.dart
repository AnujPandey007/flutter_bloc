import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../models/employee.dart';

@immutable
abstract class EmployeeEvent  extends Equatable {
  @override
  List<Object?> get props => [];
}

final class FetchEmployees extends EmployeeEvent {}

final class AddEmployee extends EmployeeEvent {
  final Employee employee;
  AddEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

final class UpdateEmployee extends EmployeeEvent {
  final Employee employee;
  UpdateEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

final class DeleteEmployee extends EmployeeEvent {
  final String employeeId;
  DeleteEmployee(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}
