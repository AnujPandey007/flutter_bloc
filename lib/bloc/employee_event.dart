import '../models/employee.dart';

abstract class EmployeeEvent {}

class FetchEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;

  AddEmployee(this.employee);
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;

  UpdateEmployee(this.employee);
}

class DeleteEmployee extends EmployeeEvent {
  final String employeeId;

  DeleteEmployee(this.employeeId);
}
