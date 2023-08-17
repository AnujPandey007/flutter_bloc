import 'package:employee_bloc/models/employee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Employee", () {
    Employee createSubject({
      String employeeId = "0",
      String? employeeName ="test",
      String? employeeDesignation="demo",
      DateTime? employeeJoiningDate,
      DateTime? employeeLeavingDate,
    }){
      employeeJoiningDate = employeeJoiningDate ?? DateTime.utc(2021);
      employeeLeavingDate ??= DateTime.utc(2023);

      return Employee(
          employeeId: employeeId,
          employeeName: employeeName!,
          employeeDesignation: employeeDesignation!,
          employeeJoiningDate: employeeJoiningDate,
          employeeLeavingDate: employeeLeavingDate
      );
    }

    test('given Employee class when Equatable is used then check whether Equatable is implemented correctly', () {
      expect(createSubject(), equals(createSubject()));
    });

    test("given Employee class when props are used then check whether props is implemented correctly", () {
      expect(createSubject().props, equals(<Object?>[...createSubject().props]));
    });


    group('copyWith', () {
      test('given Employee class when no arguments are provided then returns the same object', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });

      test('given Employee class when null is provided then retains the old value for every parameter', () {
        expect(
          createSubject().copyWith(
              employeeId: null,
              employeeName: null,
              employeeDesignation: null,
              employeeLeavingDate: null,
              employeeJoiningDate: null,
          ),
          equals(createSubject()),
        );
      });

      test('given Employee class when some values are updated then returns same object', () {
        expect(
          createSubject().copyWith(
            employeeId: "0",
            employeeName: "test1",
            employeeDesignation: "demo1",
          ),
          equals(
            createSubject(
              employeeId: "0",
              employeeName: "test1",
              employeeDesignation: "demo1",
            ),
          ),
        );
      });
    });

    group("fromJson", () {
      test("given Employee class when fromJson is used then fromJson returns a valid Employee", () {
        Map<String, dynamic> json =  {
          "employeeId": "0",
          "employeeName": "test",
          "employeeDesignation": "demo",
          "employeeJoiningDate": DateTime.utc(2021).toIso8601String(),
          "employeeLeavingDate": DateTime.utc(2023).toIso8601String(),
        };

        final mockCounter = Employee.fromMap(json);

        expect(mockCounter, equals(createSubject()));
      });
    });

    group("toJson", () {
      test("given Employee class when toJson is used then check whether Employee can be converted into json/map", () {
        Map<String, dynamic> json =  createSubject().toMap();

        Map<String, dynamic> expectedJson =  {
          "employeeId": "0",
          "employeeName": "test",
          "employeeDesignation": "demo",
          "employeeJoiningDate": DateTime.utc(2021).toIso8601String(),
          "employeeLeavingDate": DateTime.utc(2023).toIso8601String(),
        };

        expect(json, equals(expectedJson));
      });
    });
  });
}
