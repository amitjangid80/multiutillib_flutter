import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final Color? leftArrowColor;
  final Color? rightArrowColor;
  final Color? weekDaysTextColor;
  final Color? selectedDateColor;
  final Color? monthYearTextColor;
  final DateTime? initialStartDate;
  final Function(DateTime?)? onDateChange;

  const CustomCalendarView({
    Key? key,
    this.minimumDate,
    this.maximumDate,
    this.onDateChange,
    this.leftArrowColor,
    this.rightArrowColor,
    this.initialStartDate,
    this.weekDaysTextColor,
    this.monthYearTextColor,
    this.selectedDateColor,
  }) : super(key: key);

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  final List<DateTime> _dateList = [];
  var _currentMonthDate = DateTime.now();

  DateTime? _endDate;
  DateTime? _startDate;

  @override
  void initState() {
    setListOfDate(_currentMonthDate);

    if (widget.initialStartDate != null) {
      _endDate = widget.initialStartDate;
      _startDate = widget.initialStartDate;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime _monthDate) {
    _dateList.clear();

    int _previousMothDay = 0;
    final DateTime _newDate = DateTime(_monthDate.year, _monthDate.month, 0);

    if (_newDate.weekday < 7) {
      _previousMothDay = _newDate.weekday;

      for (var i = 1; i <= _previousMothDay; i++) {
        _dateList.add(_newDate.subtract(Duration(days: _previousMothDay - i)));
      }
    }

    for (var i = 0; i < (42 - _previousMothDay); i++) {
      _dateList.add(_newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      onTap: () {
                        setState(() {
                          _currentMonthDate = DateTime(_currentMonthDate.year,
                              _currentMonthDate.month, 0);
                          setListOfDate(_currentMonthDate);
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_left,
                          color: widget.leftArrowColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat("MMMM, yyyy").format(_currentMonthDate),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: widget.monthYearTextColor),
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      onTap: () {
                        setState(() {
                          _currentMonthDate = DateTime(_currentMonthDate.year,
                              _currentMonthDate.month + 2, 0);
                          setListOfDate(_currentMonthDate);
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_right,
                          color: widget.rightArrowColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Row(children: _getDaysNameUI())),
        Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Column(children: _getDaysNoUI())),
      ],
    );
  }

  List<Widget> _getDaysNameUI() {
    final List<Widget> _listUI = [];

    for (var i = 0; i < 7; i++) {
      _listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat("EEE").format(_dateList[i]),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: widget.weekDaysTextColor),
            ),
          ),
        ),
      );
    }
    return _listUI;
  }

  List<Widget> _getDaysNoUI() {
    var _count = 0;
    final List<Widget> _noList = [];

    for (var i = 0; i < _dateList.length / 7; i++) {
      final List<Widget> _listUI = [];

      for (var i = 0; i < 7; i++) {
        final _date = _dateList[_count];

        _listUI.add(
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
                          right: _isEndDateRadius(_date) ? 4 : 0,
                          left: _isStartDateRadius(_date) ? 4 : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _startDate != null && _endDate != null
                                ? _getIsItStartAndEndDate(_date) ||
                                        _getIsInRange(_date)
                                    ? widget.selectedDateColor!.withOpacity(0.4)
                                    : Colors.transparent
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topRight: _isEndDateRadius(_date)
                                  ? const Radius.circular(24.0)
                                  : const Radius.circular(0.0),
                              topLeft: _isStartDateRadius(_date)
                                  ? const Radius.circular(24.0)
                                  : const Radius.circular(0.0),
                              bottomRight: _isEndDateRadius(_date)
                                  ? const Radius.circular(24.0)
                                  : const Radius.circular(0.0),
                              bottomLeft: _isStartDateRadius(_date)
                                  ? const Radius.circular(24.0)
                                  : const Radius.circular(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      onTap: () {
                        if (_currentMonthDate.month == _date.month) {
                          if (widget.minimumDate != null &&
                              widget.maximumDate != null) {
                            final DateTime _newMinimumDate = DateTime(
                              widget.minimumDate!.year,
                              widget.minimumDate!.month,
                              widget.minimumDate!.day - 1,
                            );

                            final DateTime _newMaximumDate = DateTime(
                              widget.maximumDate!.year,
                              widget.maximumDate!.month,
                              widget.maximumDate!.day + 1,
                            );

                            if (_date.isAfter(_newMinimumDate) &&
                                _date.isBefore(_newMaximumDate)) {
                              _onDateClick(_date);
                            }
                          } else if (widget.minimumDate != null) {
                            final DateTime _newMinimumDate = DateTime(
                              widget.minimumDate!.year,
                              widget.minimumDate!.month,
                              widget.minimumDate!.day - 1,
                            );

                            if (_date.isAfter(_newMinimumDate)) {
                              _onDateClick(_date);
                            }
                          } else if (widget.maximumDate != null) {
                            final DateTime _newMaximumDate = DateTime(
                              widget.maximumDate!.year,
                              widget.maximumDate!.month,
                              widget.maximumDate!.day + 1,
                            );

                            if (_date.isBefore(_newMaximumDate)) {
                              _onDateClick(_date);
                            }
                          } else {
                            _onDateClick(_date);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getIsItStartAndEndDate(_date)
                                ? widget.selectedDateColor
                                : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32.0)),
                            border: Border.all(
                              color: _getIsItStartAndEndDate(_date)
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: _getIsItStartAndEndDate(_date)
                                ? [
                                    const BoxShadow(
                                        blurRadius: 4, color: Colors.grey)
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              "${_date.day}",
                              style: TextStyle(
                                color: _getIsItStartAndEndDate(_date)
                                    ? Colors.white
                                    : _currentMonthDate.month == _date.month
                                        ? Colors.black
                                        : Colors.grey.withOpacity(0.6),
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 18
                                        : 16,
                                fontWeight: _getIsItStartAndEndDate(_date)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
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
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (DateTime.now().day == _date.day &&
                                DateTime.now().month == _date.month &&
                                DateTime.now().year == _date.year)
                            ? _getIsInRange(_date)
                                ? Colors.white
                                : widget.selectedDateColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        _count += 1;
      }

      _noList.add(Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _listUI));
    }

    return _noList;
  }

  bool _getIsInRange(DateTime date) {
    if (_startDate != null && _endDate != null) {
      if (date.isAfter(_startDate!) && date.isBefore(_endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool _getIsItStartAndEndDate(DateTime date) {
    if (_startDate != null &&
        _startDate!.day == date.day &&
        _startDate!.month == date.month &&
        _startDate!.year == date.year) {
      return true;
    } else if (_endDate != null &&
        _endDate!.day == date.day &&
        _endDate!.month == date.month &&
        _endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool _isStartDateRadius(DateTime date) {
    if (_startDate != null &&
        _startDate!.day == date.day &&
        _startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool _isEndDateRadius(DateTime date) {
    if (_endDate != null &&
        _endDate!.day == date.day &&
        _endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void _onDateClick(DateTime date) {
    _endDate = date;
    _startDate = date;

    setState(() {
      try {
        widget.onDateChange!(_startDate);
      } catch (e) {
        debugPrint(
            'exception while check for is end date radius: ${e.toString()}');
      }
    });
  }
}
