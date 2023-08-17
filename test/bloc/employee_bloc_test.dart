import 'package:employee_bloc/bloc/employee_bloc.dart';
import 'package:employee_bloc/bloc/employee_event.dart';
import 'package:employee_bloc/bloc/employee_state.dart';
import 'package:employee_bloc/models/employee.dart';
import 'package:employee_bloc/repositories/employee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

void main() {
  group('EmployeeBloc', () {
    late MockEmployeeRepository employeeRepository;
    late EmployeeBloc employeeBloc;
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

    setUp(() {
      employeeRepository = MockEmployeeRepository();
      employeeBloc = EmployeeBloc(employeeRepository);
    });

    tearDown(() {
      employeeBloc.close();
    });

    EmployeeBloc buildBloc(){
      return employeeBloc;
    }

    group("constructor", () {
      test("given EmployeeBloc when EmployeeBloc is used then EmployeeBloc is returned without exception", () {
        expect(buildBloc, returnsNormally);
      });

      test('given EmployeeBloc when EmployeeBloc is used then EmployeeBloc has correct initial state', () {
        expect(buildBloc().state, equals(EmployeeInitial()));
      });
    });

    group("FetchEmployees", () {
      blocTest<EmployeeBloc, EmployeeState>('emits [EmployeeLoading, EmployeeInitial] when FetchEmployees is added and list in empty',
        build: () {
          when(() => employeeRepository.getEmployees()).thenAnswer((_) async => []);
          return employeeBloc;
        },
        act: (bloc) => bloc.add(FetchEmployees()),
        expect: () => [EmployeeLoading(), EmployeeInitial()],
      );

      blocTest<EmployeeBloc, EmployeeState>('emits [EmployeeLoading, EmployeeLoaded] when FetchEmployees is added and list is not empty',
        build: () {
          when(() => employeeRepository.getEmployees()).thenAnswer((_) async => [...employees]);
          return employeeBloc;
        },
        act: (bloc) => bloc.add(FetchEmployees()),
        expect: () => [EmployeeLoading(), EmployeeLoaded([...employees])],
      );

      blocTest<EmployeeBloc, EmployeeState>('emits [EmployeeLoading, EmployeeError] when FetchEmployees fails',
        build: () {
          when(() => employeeRepository.getEmployees()).thenThrow(Exception('Failed to fetch employees'));
          return employeeBloc;
        },
        act: (bloc) => bloc.add(FetchEmployees()),
        expect: () => [EmployeeLoading(), EmployeeError('Failed to fetch employees')],
      );

    });

    group("AddEmployee", () {
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

      blocTest<EmployeeBloc, EmployeeState>('emits [EmployeeAdded, EmployeeLoading, EmployeeLoaded]  when AddEmployee is added',
        build: () {
          when(() => employeeRepository.insertEmployee(employee)).thenAnswer((_) async {});
          when(() => employeeRepository.getEmployees()).thenAnswer((_) async => [...employees]);
          return employeeBloc;
        },
        act: (bloc) => bloc.add(AddEmployee(employee)),
        expect: () => [EmployeeAdded(), EmployeeLoading(), EmployeeLoaded(employees)],
      );

      blocTest<EmployeeBloc, EmployeeState>('emits [EmployeeError] when AddEmployee fails',
        build: () {
          when(() => employeeRepository.insertEmployee(employee)).thenThrow(Exception('Failed to add employee'));
          return employeeBloc;
        },
        act: (bloc) => bloc.add(AddEmployee(employee)),
        expect: () => [EmployeeError('Failed to add employee')],
      );
    });

    group("UpdateEmployee", () {

    });

    group("DeleteEmployee", () {
      
    });

  });
}