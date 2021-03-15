import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final Color leftArrowColor;
  final Color rightArrowColor;
  final DateTime initialEndDate;
  final Color weekDaysTextColor;
  final Color monthYearTextColor;
  final Color selectedRangeColor;
  final DateTime initialStartDate;
  final Function(DateTime, DateTime) startEndDateChange;

  const CustomCalendarView({
    Key key,
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
  }) : super(key: key);

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = [];
  DateTime endDate, startDate;
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
    var newDate = DateTime(monthDate.year, monthDate.month, 0);

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
                    border: Border.all(color: widget.leftArrowColor),
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      child: Icon(Icons.keyboard_arrow_left, color: widget.leftArrowColor),
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
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
                    border: Border.all(color: widget.rightArrowColor),
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                      child: Icon(Icons.keyboard_arrow_right, color: widget.rightArrowColor),
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(child: Row(children: getDaysNameUI()), padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8)),
        Padding(child: Column(children: getDaysNoUI()), padding: const EdgeInsets.only(right: 8, left: 8)),
      ],
    );
  }

  List<Widget> getDaysNameUI() {
    List<Widget> listUI = [];

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
    var _count = 0;
    List<Widget> _noList = [];

    for (var i = 0; i < dateList.length / 7; i++) {
      List<Widget> _listUI = [];

      for (var i = 0; i < 7; i++) {
        final _date = dateList[_count];

        _listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
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
                            right: isEndDateRadius(_date) ? 4 : 0,
                            left: isStartDateRadius(_date) ? 4 : 0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: startDate != null && endDate != null
                                  ? getIsItStartAndEndDate(_date) || getIsInRange(_date)
                                      ? widget.selectedRangeColor.withOpacity(0.4)
                                      : Colors.transparent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topRight: isEndDateRadius(_date) ? Radius.circular(24.0) : Radius.circular(0.0),
                                topLeft: isStartDateRadius(_date) ? Radius.circular(24.0) : Radius.circular(0.0),
                                bottomRight: isEndDateRadius(_date) ? Radius.circular(24.0) : Radius.circular(0.0),
                                bottomLeft: isStartDateRadius(_date) ? Radius.circular(24.0) : Radius.circular(0.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {
                          if (currentMonthDate.month == _date.month) {
                            if (widget.minimumDate != null && widget.maximumDate != null) {
                              var newMinimumDate = DateTime(
                                widget.minimumDate.year,
                                widget.minimumDate.month,
                                widget.minimumDate.day - 1,
                              );

                              var newMaximumDate = DateTime(
                                widget.maximumDate.year,
                                widget.maximumDate.month,
                                widget.maximumDate.day + 1,
                              );

                              if (_date.isAfter(newMinimumDate) && _date.isBefore(newMaximumDate)) {
                                onDateClick(_date);
                              }
                            } else if (widget.minimumDate != null) {
                              var newMinimumDate = DateTime(
                                widget.minimumDate.year,
                                widget.minimumDate.month,
                                widget.minimumDate.day - 1,
                              );

                              if (_date.isAfter(newMinimumDate)) {
                                onDateClick(_date);
                              }
                            } else if (widget.maximumDate != null) {
                              var newMaximumDate = DateTime(
                                widget.maximumDate.year,
                                widget.maximumDate.month,
                                widget.maximumDate.day + 1,
                              );

                              if (_date.isBefore(newMaximumDate)) {
                                onDateClick(_date);
                              }
                            } else {
                              onDateClick(_date);
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: getIsItStartAndEndDate(_date) ? widget.selectedRangeColor : Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                              border: Border.all(
                                width: 2,
                                color: getIsItStartAndEndDate(_date) ? Colors.white : Colors.transparent,
                              ),
                              boxShadow: getIsItStartAndEndDate(_date)
                                  ? [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 0))]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                "${_date.day}",
                                style: TextStyle(
                                  color: getIsItStartAndEndDate(_date)
                                      ? Colors.white
                                      : currentMonthDate.month == _date.month
                                          ? Colors.black
                                          : Colors.grey.withOpacity(0.6),
                                  fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                                  fontWeight: getIsItStartAndEndDate(_date) ? FontWeight.bold : FontWeight.normal,
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
                          color: (DateTime.now().day == _date.day &&
                                  DateTime.now().month == _date.month &&
                                  DateTime.now().year == _date.year)
                              ? getIsInRange(_date)
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
          ),
        );

        _count += 1;
      }

      _noList.add(
        Row(
          children: _listUI,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      );
    }
    return _noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate) && date.isBefore(endDate)) {
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
        startDate.day == date.day &&
        startDate.month == date.month &&
        startDate.year == date.year) {
      return true;
    } else if (endDate != null && endDate.day == date.day && endDate.month == date.month && endDate.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null && startDate.day == date.day && startDate.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null && endDate.day == date.day && endDate.month == date.month) {
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
      if (startDate.isAfter(date)) {
        endDate = startDate;
        startDate = date;
      } else if (startDate.isBefore(date)) {
        endDate = date;
      }
    }

    setState(() {
      try {
        widget.startEndDateChange(startDate, endDate);
      } catch (e) {}
    });
  }
}
