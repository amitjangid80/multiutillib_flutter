import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final Color? leftArrowColor;
  final Color? rightArrowColor;
  final DateTime? initialEndDate;
  final Color? weekDaysTextColor;
  final Color? monthYearTextColor;
  final Color? selectedRangeColor;
  final DateTime? initialStartDate;
  final Function(DateTime?, DateTime?)? startEndDateChange;

  const CustomCalendarView({
    super.key,
    this.minimumDate,
    this.maximumDate,
    this.initialEndDate,
    this.leftArrowColor,
    this.rightArrowColor,
    this.initialStartDate,
    this.weekDaysTextColor,
    this.monthYearTextColor,
    this.startEndDateChange,
    this.selectedRangeColor,
  });

  @override
  CustomCalendarViewState createState() => CustomCalendarViewState();
}

class CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = [];
  DateTime? endDate, startDate;
  var currentMonthDate = DateTime.now();

  @override
  void initState() {
    setListOfDate(currentMonthDate);

    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }

    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    int previousMonthDay = 0;
    final newDate = DateTime(monthDate.year, monthDate.month, 0);

    if (newDate.weekday < 7) {
      previousMonthDay = newDate.weekday;

      for (var i = 1; i <= previousMonthDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMonthDay - i)));
      }
    }

    for (var i = 0; i < (42 - previousMonthDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.leftArrowColor!),
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_left, color: widget.leftArrowColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat("MMMM, yyyy").format(currentMonthDate),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: widget.monthYearTextColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.rightArrowColor!),
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_right, color: widget.rightArrowColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8), child: Row(children: getDaysNameUI())),
        Padding(padding: const EdgeInsets.only(right: 8, left: 8), child: Column(children: getDaysNoUI())),
      ],
    );
  }

  List<Widget> getDaysNameUI() {
    final List<Widget> listUI = [];

    for (var i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat("EEE").format(dateList[i]),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: widget.weekDaysTextColor),
            ),
          ),
        ),
      );
    }

    return listUI;
  }

  List<Widget> getDaysNoUI() {
    var count = 0;
    final List<Widget> noList = [];

    for (var i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = [];

      for (var i = 0; i < 7; i++) {
        final date = dateList[count];

        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          right: isEndDateRadius(date) ? 4 : 0,
                          left: isStartDateRadius(date) ? 4 : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: startDate != null && endDate != null
                                ? getIsItStartAndEndDate(date) || getIsInRange(date)
                                    ? widget.selectedRangeColor!.withOpacity(0.4)
                                    : Colors.transparent
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topRight:
                                  isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                              topLeft:
                                  isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                              bottomRight:
                                  isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                              bottomLeft:
                                  isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                      onTap: () {
                        if (currentMonthDate.month == date.month) {
                          if (widget.minimumDate != null && widget.maximumDate != null) {
                            final newMinimumDate = DateTime(
                              widget.minimumDate!.year,
                              widget.minimumDate!.month,
                              widget.minimumDate!.day - 1,
                            );

                            final newMaximumDate = DateTime(
                              widget.maximumDate!.year,
                              widget.maximumDate!.month,
                              widget.maximumDate!.day + 1,
                            );

                            if (date.isAfter(newMinimumDate) && date.isBefore(newMaximumDate)) {
                              onDateClick(date);
                            }
                          } else if (widget.minimumDate != null) {
                            final newMinimumDate = DateTime(
                              widget.minimumDate!.year,
                              widget.minimumDate!.month,
                              widget.minimumDate!.day - 1,
                            );

                            if (date.isAfter(newMinimumDate)) {
                              onDateClick(date);
                            }
                          } else if (widget.maximumDate != null) {
                            final newMaximumDate = DateTime(
                              widget.maximumDate!.year,
                              widget.maximumDate!.month,
                              widget.maximumDate!.day + 1,
                            );

                            if (date.isBefore(newMaximumDate)) {
                              onDateClick(date);
                            }
                          } else {
                            onDateClick(date);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getIsItStartAndEndDate(date) ? widget.selectedRangeColor : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                            border: Border.all(
                              width: 2,
                              color: getIsItStartAndEndDate(date) ? Colors.white : Colors.transparent,
                            ),
                            boxShadow: getIsItStartAndEndDate(date)
                                ? [const BoxShadow(blurRadius: 4, color: Colors.grey)]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              "${date.day}",
                              style: TextStyle(
                                color: getIsItStartAndEndDate(date)
                                    ? Colors.white
                                    : currentMonthDate.month == date.month
                                        ? Colors.black
                                        : Colors.grey.withOpacity(0.6),
                                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                                fontWeight: getIsItStartAndEndDate(date) ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 9,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (DateTime.now().day == date.day &&
                                DateTime.now().month == date.month &&
                                DateTime.now().year == date.year)
                            ? getIsInRange(date)
                                ? Colors.white
                                : widget.selectedRangeColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        count += 1;
      }

      noList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: listUI,
        ),
      );
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null &&
        startDate!.day == date.day &&
        startDate!.month == date.month &&
        startDate!.year == date.year) {
      return true;
    } else if (endDate != null &&
        endDate!.day == date.day &&
        endDate!.month == date.month &&
        endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null && endDate!.day == date.day && endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (startDate != null) {
      if (startDate!.isAfter(date)) {
        endDate = startDate;
        startDate = date;
      } else if (startDate!.isBefore(date)) {
        endDate = date;
      }
    }

    setState(() {
      try {
        widget.startEndDateChange!(startDate, endDate);
      } catch (e) {
        debugPrint('exception while calling start end date change method');
      }
    });
  }
}
