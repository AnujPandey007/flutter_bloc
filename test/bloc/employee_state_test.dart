import 'package:employee_bloc/bloc/employee_state.dart';
import 'package:employee_bloc/models/employee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeState', () {

    group("EmployeeInitial", () {
      test("given EmployeeInitial class then check whether EmployeeInitial extends to EmployeeState", () {
        expect(EmployeeInitial(), isA<EmployeeState>());
      });
      test('given EmployeeInitial class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(EmployeeInitial(), equals(EmployeeInitial()));
      });
      test("given EmployeeInitial class when props are used then check whether props is implemented correctly", () {
        expect(EmployeeInitial().props, equals(<Object?>[]));
      });
    });

    group("EmployeeLoading", () {
      test("given EmployeeLoading class then check whether EmployeeLoading extends to EmployeeState", () {
        expect(EmployeeLoading(), isA<EmployeeState>());
      });
      test('given EmployeeLoading class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(EmployeeLoading(), equals(EmployeeLoading()));
      });
      test("given EmployeeLoading class when props are used then check whether props is implemented correctly", () {
        expect(EmployeeLoading().props, equals(<Object?>[]));
      });
    });

    group("EmployeeLoaded", () {
      late List<Employee> employees;

      setUp(() {
        employees = [
          Employee(
              employeeId: "0",
              employeeName: "test",
              employeeDesignation: "demo",
              employeeLeavingDate: DateTime.utc(2023),
              employeeJoiningDate: DateTime.utc(2021)
          ),
          Employee(
              employeeId: "1",
              employeeName: "test1",
              employeeDesignation: "demo1",
              employeeLeavingDate: DateTime.utc(2022),
              employeeJoiningDate: DateTime.utc(2020)
          ),
        ];
      });

      test("given EmployeeLoaded class then check whether EmployeeLoaded extends to EmployeeState", () {
        expect(EmployeeLoaded(employees), isA<EmployeeState>());
      });

      test('given EmployeeLoaded class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(EmployeeLoaded(employees), equals(EmployeeLoaded(employees)));
      });

      test("given EmployeeLoaded class when props are used then check whether props is implemented correctly", () {
        expect(EmployeeLoaded(employees).props, equals(<Object?>[...employees]));
      });
    });

    group("EmployeeAdded", () {
      test("given EmployeeAdded class then check whether EmployeeAdded extends to EmployeeState", () {
        expect(EmployeeAdded(), isA<EmployeeState>());
      });
      test('given EmployeeAdded class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(EmployeeAdded(), equals(EmployeeAdded()));
      });
      test("given EmployeeAdded class when props are used then check whether props is implemented correctly", () {
        expect(EmployeeAdded().props, equals(<Object?>[]));
      });
    });

    group("EmployeeUpdated", () {
      test("given EmployeeUpdated class then check whether EmployeeUpdated extends to EmployeeState", () {
        expect(EmployeeUpdated(), isA<EmployeeState>());
      });
      test('given EmployeeUpdated class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(EmployeeUpdated(), equals(EmployeeUpdated()));
      });
      test("given EmployeeUpdated class when props are used then check whether props is implemented correctly", () {
        expect(EmployeeUpdated().props, equals(<Object?>[]));
      });
    });

    group("EmployeeDeleted", () {
      test("given EmployeeDeleted class then check whether EmployeeDeleted extends to EmployeeState", () {
        expect(EmployeeDeleted(), isA<EmployeeState>());
      });
      test('given EmployeeDeleted class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(EmployeeDeleted(), equals(EmployeeDeleted()));
      });
      test("given EmployeeDeleted class when props are used then check whether props is implemented correctly", () {
        expect(EmployeeDeleted().props, equals(<Object?>[]));
      });
    });

    group("EmployeeError", () {
      late String errorMessage;

      setUp(() {
        errorMessage = 'An error occurred';
      });

      test("given EmployeeError class then check whether EmployeeError extends to EmployeeState", () {
        expect(EmployeeError(errorMessage), isA<EmployeeState>());
      });
      test('given EmployeeError class when Equatable is used then check whether Equatable is implemented correctly', () {
        expect(EmployeeError(errorMessage), equals(EmployeeError(errorMessage)));
      });
      test("given EmployeeDeleted class when props are used then check whether props is implemented correctly", () {
        expect(EmployeeError(errorMessage).props, equals(<Object?>[errorMessage]));
      });
    });

  });
}
