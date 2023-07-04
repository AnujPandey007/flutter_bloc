class Employee {
  String? employeeId;
  String employeeName;
  String employeeDesignation;
  DateTime employeeJoiningDate;
  DateTime employeeLeavingDate;

  Employee({required this.employeeId, required this.employeeName, required this.employeeDesignation, required this.employeeJoiningDate, required this.employeeLeavingDate});

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
}
