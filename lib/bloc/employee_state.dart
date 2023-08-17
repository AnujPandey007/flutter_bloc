import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../models/employee.dart';

@immutable
abstract class EmployeeState extends Equatable{
  @override
  List<Object?> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;
  EmployeeLoaded(this.employees);

  @override
  List<Object?> get props => [...employees];
}

final class EmployeeAdded extends EmployeeState {}

final class EmployeeUpdated extends EmployeeState {}

final class EmployeeDeleted extends EmployeeState {}

final class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
