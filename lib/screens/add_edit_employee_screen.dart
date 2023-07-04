import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../models/employee.dart';
import '../shared/custom_calendar.dart';
import '../shared/input_decoration.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const AddEditEmployeeScreen({super.key, required this.employee});

  @override
  _AddEditEmployeeScreenState createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  late TextEditingController _nameController;
  late String _designation;
  final _formKey = GlobalKey<FormState>();
  final List<String> jobRoles =  ['Product Designer', 'Flutter Developer', 'QA Tester', 'Product Owner'];
  late DateTime employeeJoiningDate;
  late DateTime employeeLeavingDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.employeeName ?? '');
    _designation =  widget.employee?.employeeDesignation ?? '';
    employeeJoiningDate = widget.employee?.employeeJoiningDate ?? DateTime.now();
    employeeLeavingDate = widget.employee?.employeeLeavingDate ?? DateTime.utc(3000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.employee != null ? 'Edit Employee Details' : 'Add Employee Details'),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          if(widget.employee!=null)...[
            GestureDetector(
              onTap: () {
                BlocProvider.of<EmployeeBloc>(context).add(DeleteEmployee(widget.employee?.employeeId ?? "0"));
                const snackBar = SnackBar(
                  content: Text('Employee data has been deleted'),
                  backgroundColor: (Colors.black),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                  "assets/images/delete.svg",
                  semanticsLabel: 'delete'
              ),
            ),
            const SizedBox(width: 16),
          ]
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            color: Colors.blue.withOpacity(0.1),
            elevation: 0,
            minWidth: MediaQuery.of(context).size.width*0.05,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.blue
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
          const SizedBox(width: 16,),
          MaterialButton(
            color: Colors.blue,
            elevation: 0,
            minWidth: MediaQuery.of(context).size.width*0.05,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                var uuid = const Uuid();
                final id = widget.employee?.employeeId ?? uuid.v4().toString();
                final name = _nameController.text.trim();
                final designation = _designation.trim();
                final initialDate = employeeJoiningDate;
                final finalDate = employeeLeavingDate;

                if (name.isNotEmpty && designation.isNotEmpty) {
                  final employee = Employee(
                      employeeId: id,
                      employeeName: name,
                      employeeDesignation: designation,
                      employeeJoiningDate: initialDate,
                      employeeLeavingDate: finalDate
                  );
                  if (widget.employee != null) {
                    BlocProvider.of<EmployeeBloc>(context).add(UpdateEmployee(employee));
                  } else {
                    BlocProvider.of<EmployeeBloc>(context).add(AddEmployee(employee));
                  }
                  Navigator.pop(context);
                }else{
                  const snackBar = SnackBar(
                    content: Text('Fill the details'),
                    backgroundColor: (Colors.black),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }else{
                const snackBar = SnackBar(
                  content: Text('Fill the details'),
                  backgroundColor: (Colors.black),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextFormField(
                  decoration: textInputDecoration,
                  autofocus: false,
                  validator: (val) => (val==null||val.isEmpty) ? 'Enter Name' : null,
                  controller: _nameController,
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                    bottomSheetDropDown(context, jobRoles);
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: DropdownButtonFormField(
                      decoration: dropDownInputDecoration,
                      value: _designation== "" ? null: _designation,
                      icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.blue,),
                      iconSize: 30,
                      validator: (val) => (val==null||val.isEmpty) ? 'Select Role' : null,
                      elevation: 16,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black, fontSize: 16.0),
                      onChanged: (newValue) {
                        setState(() {
                          _designation = newValue!;
                        });
                      },
                      onTap: () {
                        print("Tapped");
                      },
                      items: jobRoles.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async{
                        final date = await pickDate(context, DateTime(DateTime.now().year, DateTime.now().month-1), employeeJoiningDate, employeeLeavingDate, true);
                        if (date == null){
                          return;
                        }
                        setState(() {
                          employeeJoiningDate = date;
                          if(employeeJoiningDate.isAfter(employeeLeavingDate)){
                            employeeLeavingDate =  DateTime.utc(3000);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                        child: Row(
                          children: [
                            // const Icon(Icons.calendar_month_outlined,color: Colors.blue, ),
                            SvgPicture.asset(
                                "assets/images/event.svg",
                                semanticsLabel: 'event'
                            ),
                            const SizedBox(width: 6,),
                            Text(
                                (employeeJoiningDate.day==DateTime.now().day && employeeJoiningDate.month==DateTime.now().month&&employeeJoiningDate.year==DateTime.now().year ? "Today": ("${employeeJoiningDate.day} ${DateFormat.MMM().format(employeeJoiningDate)} ${employeeJoiningDate.year}")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 20,),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async{
                        final date = await pickDate(context, employeeJoiningDate, employeeJoiningDate, employeeLeavingDate, false);
                        if (date == null){
                          return;
                        }
                        setState(() {
                          employeeLeavingDate = date;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.all(7),
                        child: Row(
                          children:  [
                            SvgPicture.asset(
                                "assets/images/event.svg",
                                semanticsLabel: 'event'
                            ),
                            const SizedBox(width: 6,),
                            Text(
                              employeeLeavingDate == DateTime.utc(3000) ? "No date" : ("${employeeLeavingDate.day} ${DateFormat.MMM().format(employeeLeavingDate)} ${employeeLeavingDate.year}"),
                              style: const TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate(BuildContext context, DateTime firstDay, DateTime focusedDay, DateTime employeeLeavingDate, bool isJoiningTime) async {
    final selectedDate = await showDialog(
      context: context,
      builder: (context) {
        return CustomCalendar(firstDay: firstDay, focusedDay: focusedDay, employeeLeavingDate: employeeLeavingDate, isJoiningTime: isJoiningTime);
      }
    );
    return selectedDate;
  }

  Future<void> bottomSheetDropDown(context, List<String> jobRoles) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (BuildContext context) {
          return ListView.separated(
            itemCount: jobRoles.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.grey,
              );
            },
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _designation = jobRoles[index];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )
                  ),
                  child: Text(
                    jobRoles[index],
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          );
        }
    );
  }


}
