import 'package:employee_bloc/bloc/employee_event.dart';
import 'package:employee_bloc/models/employee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeEvent', () {
    late Employee employee;
    setUp(() {
      employee = Employee(
          employeeId: "0",
          employeeName: "test",
          employeeDesignation: "demo",
          employeeJoiningDate: DateTime.utc(2021),
          employeeLeavingDate: DateTime.utc(2023)
      );
    });

    group("FetchEmployees", () {
      test('given FetchEmployees class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(FetchEmployees(), equals(FetchEmployees()));
      });
      test("given FetchEmployees class when props are used then check whether props is implemented correctly", () {
        expect(FetchEmployees().props, equals(<Object?>[]));
      });
    });

    group("AddEmployee", () {
      test('given AddEmployee class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(AddEmployee(employee), equals(AddEmployee(employee)));
      });
      test("given AddEmployee class when props are used then check whether props is implemented correctly", () {
        expect(AddEmployee(employee).props, equals(<Object?>[employee]));
      });
    });

    group("UpdateEmployee", () {
      test('given UpdateEmployee class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(UpdateEmployee(employee), equals(UpdateEmployee(employee)));
      });
      test("given UpdateEmployee class when props are used then check whether props is implemented correctly", () {
        expect(UpdateEmployee(employee).props, equals(<Object?>[employee]));
      });
    });

    group("DeleteEmployee", () {
      late String employeeId;
      setUp(() {
        employeeId = "0";
      });

      test('given DeleteEmployee class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(DeleteEmployee(employeeId), equals(DeleteEmployee(employeeId)));
      });
      test("given DeleteEmployee class when props are used then check whether props is implemented correctly", () {
        expect(DeleteEmployee(employeeId).props, equals(<Object?>[employeeId]));
      });
    });
  });
}
