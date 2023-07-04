import 'package:employee_bloc/screens/add_edit_employee_screen.dart';
import 'package:employee_bloc/shared/custom_header.dart';
import 'package:employee_bloc/shared/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';
import '../models/employee.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmployeeBloc>(context).add(FetchEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if(state is EmployeeInitial){
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Frame.png"),
                  const Text(
                      "No employee records found",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF323238),
                          fontWeight: FontWeight.w500
                      )
                  )
                ],
              ),
            );
          }else if (state is EmployeeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmployeeLoaded) {
            List<Employee> currentEmployees = state.employees.where((employee) => employee.employeeLeavingDate==DateTime.utc(3000)).toList();
            List<Employee> previousEmployees = state.employees.where((employee) => employee.employeeLeavingDate!=DateTime.utc(3000)).toList();

            return Column(
              children: [
                const CustomHeader(headerTitle: "Current employees",),
                CustomListView(employeeList: currentEmployees, isCurrentList: true),
                const CustomHeader(headerTitle:  "Previous employees",),
                CustomListView(employeeList: previousEmployees, isCurrentList: false),
              ],
            );
          } else if (state is EmployeeError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          return Container(
            color: state is EmployeeInitial ? Colors.white : Colors.grey.shade200,
            height: MediaQuery.of(context).size.height*0.1,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: state is EmployeeInitial ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state is EmployeeLoaded)...[
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                        "Swipe left to delete",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )
                    ),
                  ),
                ],
                Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 0,
                    onPressed: () {
                      // EmployeeRepository().deleteDb();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddEditEmployeeScreen(employee: null)));
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
