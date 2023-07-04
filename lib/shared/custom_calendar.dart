import 'package:employee_bloc/shared/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime firstDay;
  final DateTime focusedDay;
  final DateTime employeeLeavingDate;
  final bool isJoiningTime;
  const CustomCalendar({required this.firstDay, required this.focusedDay, required this.employeeLeavingDate, required this.isJoiningTime, super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final List<String> leavingTimeChoices = ["No date", "Today"];
  late List<String> joiningTimeChoices;
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  int _defaultChoiceIndex = 0;

  @override
  void initState() {
    super.initState();
    joiningTimeChoices = [
      "Today",
      "Next ${DateFormat.EEEE().format(DateTime(widget.focusedDay.year, widget.focusedDay.month, widget.focusedDay.day + 1))}",
      "Next ${DateFormat.EEEE().format(DateTime(widget.focusedDay.year, widget.focusedDay.month, widget.focusedDay.day + 2))}",
      "After 1 week"
    ];
    _selectedDate = widget.isJoiningTime ? widget.focusedDay : widget.employeeLeavingDate;
    _focusedDate = widget.focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      backgroundColor: Colors.grey.shade100,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: MediaQuery.of(context).size.height*0.62,
        width: MediaQuery.of(context).size.width*0.93,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  childAspectRatio: 8 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5),
              shrinkWrap: true,
              itemCount: widget.isJoiningTime ? joiningTimeChoices.length : leavingTimeChoices.length,
              itemBuilder: (BuildContext context, int index) {
                return ChoiceChip(
                  label: Container(
                    width: MediaQuery.of(context).size.width*0.35,
                    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    child: Text(
                      widget.isJoiningTime ? joiningTimeChoices[index] : leavingTimeChoices[index],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  labelStyle: TextStyle(color: _defaultChoiceIndex == index ? Colors.white: Colors.blue),
                  selected: _defaultChoiceIndex == index,
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      _defaultChoiceIndex = selected ? index : 0;
                      if(widget.isJoiningTime){
                        if(_defaultChoiceIndex==0){
                          _selectedDate = DateTime.now();
                        }else if(_defaultChoiceIndex==1){
                          _selectedDate = DateTime(widget.focusedDay.year, widget.focusedDay.month, widget.focusedDay.day + 1);
                        }else if(_defaultChoiceIndex==2){
                          _selectedDate = DateTime(widget.focusedDay.year, widget.focusedDay.month, widget.focusedDay.day + 2);
                        }else if(_defaultChoiceIndex==3){
                          _selectedDate = DateTime(widget.focusedDay.year,widget.focusedDay.month, widget.focusedDay.day + 7);
                        }
                      }else{
                        if(_defaultChoiceIndex==0){
                          _selectedDate = DateTime.utc(3000);
                        }else{
                          if(widget.firstDay.isBefore(DateTime.now())){
                            _selectedDate = DateTime.now();
                          }else{
                            _selectedDate = widget.firstDay;
                          }
                        }
                      }
                    });
                  },
                );
              },
            ),
            // Text('Selected Date: $_selectedDate'),
            TableCalendar(
              // today's date
              firstDay: widget.firstDay,
              // earliest possible date
              focusedDay: _focusedDate,
              // latest allowed date
              lastDay: DateTime.utc(2030, 1, 1),
              // default view when displayed
              calendarFormat: CalendarFormat.month,
              // default is Saturday & Sunday but can be set to any day.
              // instead of day, a number can be mentioned as well.
              weekendDays: const [DateTime.sunday, 6],
              // default is Sunday but can be changed according to locale
              startingDayOfWeek: StartingDayOfWeek.sunday,
              // height between the day row and 1st date row, default is 16.0
              daysOfWeekHeight: 40.0,
              rowHeight: 40.0,
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600),
                titleCentered: true,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                headerMargin: EdgeInsets.symmetric(vertical: 0),
                headerPadding: EdgeInsets.symmetric(vertical: 0),
                formatButtonVisible: false,
                leftChevronIcon: Icon(
                  Icons.arrow_left_rounded,
                  color: Colors.grey,
                  size: 40,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_right_rounded,
                  color: Colors.grey,
                  size: 40,
                ),
                leftChevronPadding: EdgeInsets.all(5),
                leftChevronMargin: EdgeInsets.only(left: 50),
                rightChevronPadding: EdgeInsets.all(5),
                rightChevronMargin: EdgeInsets.only(right: 50),
              ),
              // Calendar Days Styling
              daysOfWeekStyle: const DaysOfWeekStyle(
                // Weekend days color (Sat,Sun)
                weekendStyle: TextStyle(color: Colors.black),
              ),
              // Calendar Dates styling
              calendarStyle: CalendarStyle(
                // Weekend dates color (Sat & Sun Column)
                weekendTextStyle: const TextStyle(color: Colors.black),
                // highlighted color for today
                todayDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue)
                ),
                todayTextStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.blue
                ),
                selectedTextStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white
                ),
                outsideDaysVisible: false,
                // highlighted color for selected day
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              // selectedDayPredicate: (day) {
              //   return isSameDay(_selectedDate, day);
              // },
              // onDaySelected: (selectedDay, focusedDay) {
              //   setState(() {
              //     _selectedDate = selectedDay;
              //     // _focusedDate = focusedDay;
              //   });
              // },
              selectedDayPredicate: (currentSelectedDate) {
                return (isSameDay(_selectedDate, currentSelectedDate));
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDate, selectedDay)) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDate = focusedDay;
                  });
                }
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                          "assets/images/event.svg",
                          semanticsLabel: 'event'
                      ),
                      const SizedBox(width: 6,),
                      Text(
                        _selectedDate == DateTime.utc(3000) ? "No date" : "${_selectedDate.day} ${DateFormat.MMM().format(_selectedDate)} ${_selectedDate.year}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            Navigator.pop(context, _selectedDate);
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
