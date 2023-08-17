import 'package:equatable/equatable.dart';

class Employee extends Equatable{
  final String? employeeId;
  final String employeeName;
  final String employeeDesignation;
  final DateTime employeeJoiningDate;
  final DateTime employeeLeavingDate;

  const Employee({required this.employeeId, required this.employeeName, required this.employeeDesignation, required this.employeeJoiningDate, required this.employeeLeavingDate});

  Employee copyWith({
    String? employeeId,
    String? employeeName,
    String? employeeDesignation,
    DateTime? employeeJoiningDate,
    DateTime? employeeLeavingDate,
  }) {
    return Employee(
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      employeeDesignation: employeeDesignation ?? this.employeeDesignation,
      employeeJoiningDate: employeeJoiningDate ?? this.employeeJoiningDate,
      employeeLeavingDate: employeeLeavingDate ?? this.employeeLeavingDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'employeeDesignation': employeeDesignation,
      'employeeJoiningDate': employeeJoiningDate.toIso8601String(),
      'employeeLeavingDate': employeeLeavingDate.toIso8601String(),
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeId: map['employeeId'],
      employeeName: map['employeeName'],
      employeeDesignation: map['employeeDesignation'],
      employeeJoiningDate: DateTime.parse(map['employeeJoiningDate']),
      employeeLeavingDate: DateTime.parse(map['employeeLeavingDate']),
    );
  }

  @override
  List<Object?> get props => [
    employeeId,
    employeeName,
    employeeDesignation,
    employeeJoiningDate,
    employeeDesignation
  ];
}
