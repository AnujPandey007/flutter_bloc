import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_event.dart';
import 'employee_state.dart';
import '../repositories/employee_repository.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _repository;

  EmployeeBloc(this._repository) : super(EmployeeInitial()){

    on<FetchEmployees>((event, emit) async {
      emit(EmployeeLoading());
      try {
        final employees = await _repository.getEmployees();
        if(employees.isEmpty){
          emit(EmployeeInitial());
        }else{
          emit(EmployeeLoaded(employees));
        }
      } catch (e) {
        emit(EmployeeError('Failed to fetch employees'));
      }
    });

    on<AddEmployee>((event, emit) async {
      try {
        await _repository.insertEmployee(event.employee);
        emit(EmployeeAdded());
        add(FetchEmployees());
      } catch (e) {
        emit(EmployeeError('Failed to add employee'));
      }
    });

    on<UpdateEmployee>((event, emit) async {
      try {
        await _repository.updateEmployee(event.employee);
        emit(EmployeeUpdated());
        add(FetchEmployees());
      } catch (e) {
        emit(EmployeeError('Failed to update employee'));
      }
    });

    on<DeleteEmployee>((event, emit) async {
      try {
        await _repository.deleteEmployee(event.employeeId);
        emit(EmployeeDeleted());
        add(FetchEmployees());
      } catch (e) {
        emit(EmployeeError('Failed to delete employee'));
      }
    });
  }

}