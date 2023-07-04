import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../models/employee.dart';
import '../screens/add_edit_employee_screen.dart';

class CustomListView extends StatelessWidget {
  final List<Employee> employeeList;
  final bool isCurrentList;
  const CustomListView({super.key, required this.employeeList, required this.isCurrentList});

  @override
  Widget build(BuildContext context) {
    if(employeeList.isEmpty){
      return Container();
    }else{
      return Expanded(
        child: ListView.separated(
          itemCount: employeeList.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey.shade300,
            );
          },
          itemBuilder: (context, index) {
            final employee = employeeList[index];

            final employeeName = employee.employeeName;
            final employeeDesignation = employee.employeeDesignation;
            final employeeJoiningDate = employee.employeeJoiningDate;
            final employeeLeavingDate = employee.employeeLeavingDate;
            final employeeTime = isCurrentList ?
            "From ${employeeJoiningDate.day} ${DateFormat.MMM().format(employeeJoiningDate)}, ${employeeJoiningDate.year}"
                : "${employeeJoiningDate.day} ${DateFormat.MMM().format(employeeJoiningDate)}, ${employeeJoiningDate.year} - ${employeeLeavingDate.day} ${DateFormat.MMM().format(employeeLeavingDate)}, ${employeeLeavingDate.year}";

            return Dismissible(
              key: Key(employee.employeeId!),
              background: Container(),
              secondaryBackground: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SvgPicture.asset(
                          "assets/images/delete.svg",
                          semanticsLabel: 'delete'
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  BlocProvider.of<EmployeeBloc>(context).add(DeleteEmployee(employee.employeeId!));
                  const snackBar = SnackBar(
                    content: Text('Employee data has been deleted'),
                    backgroundColor: (Colors.black),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  // print(employee.employeeName);
                }
                return null;
              },
              child: ListTile(
                title: Text(
                  employeeName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      employeeDesignation,
                      style: const TextStyle(
                          fontSize: 14
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      employeeTime,
                      style: const TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
                isThreeLine: true,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddEditEmployeeScreen(employee: employee)));
                },
              ),
            );
          },
        ),
      );
    }
  }
}
