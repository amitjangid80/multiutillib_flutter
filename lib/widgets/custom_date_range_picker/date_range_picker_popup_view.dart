import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:multiutillib/widgets/custom_date_range_picker/date_range_picker_calendar_view.dart';

showCustomDateRangePicker({
  required BuildContext context,
  required Function onCancelClick,
  String applyButtonText = 'Apply',
  String cancelButtonText = 'Cancel',
  Color leftArrowColor = Colors.blue,
  Color rightArrowColor = Colors.blue,
  Color applyButtonColor = Colors.blue,
  Color cancelButtonColor = Colors.red,
  Color weekDaysTextColor = Colors.blue,
  Color selectedRangeColor = Colors.blue,
  Color monthYearTextColor = Colors.black,
  required Function(DateTime? startDate, DateTime? endDate)? onApplyClick,
  TextStyle applyButtonTextStyle = const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
  TextStyle cancelButtonTextStyle = const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
  DateTime? minimumDate,
  DateTime? maximumDate,
  DateTime? initialEndDate,
  DateTime? initialStartDate,
  bool barrierDismissible = false,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => _CalendarPopupView(
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      onApplyClick: onApplyClick,
      onCancelClick: onCancelClick,
      initialEndDate: initialEndDate,
      leftArrowColor: leftArrowColor,
      rightArrowColor: rightArrowColor,
      applyButtonText: applyButtonText,
      cancelButtonText: cancelButtonText,
      applyButtonColor: applyButtonColor,
      cancelButtonColor: cancelButtonColor,
      weekDaysTextColor: weekDaysTextColor,
      monthYearTextColor: monthYearTextColor,
      selectedRangeColor: selectedRangeColor,
      barrierDismissible: barrierDismissible,
      applyButtonTextStyle: applyButtonTextStyle,
      cancelButtonTextStyle: cancelButtonTextStyle,
      initialStartDate: initialStartDate ?? DateTime.now(),
    ),
  );
}

class _CalendarPopupView extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool? barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime?, DateTime?)? onApplyClick;
  final Function? onCancelClick;
  final String? applyButtonText;
  final String? cancelButtonText;
  final Color? applyButtonColor;
  final Color? cancelButtonColor;
  final TextStyle? applyButtonTextStyle;
  final TextStyle? cancelButtonTextStyle;
  final Color? weekDaysTextColor;
  final Color? monthYearTextColor;
  final Color? leftArrowColor;
  final Color? rightArrowColor;
  final Color? selectedRangeColor;

  const _CalendarPopupView({
    Key? key,
    this.minimumDate,
    this.maximumDate,
    this.onApplyClick,
    this.onCancelClick,
    this.initialEndDate,
    this.leftArrowColor,
    this.rightArrowColor,
    this.applyButtonText,
    this.cancelButtonText,
    this.initialStartDate,
    this.applyButtonColor,
    this.cancelButtonColor,
    this.weekDaysTextColor,
    this.monthYearTextColor,
    this.barrierDismissible,
    this.selectedRangeColor,
    this.applyButtonTextStyle,
    this.cancelButtonTextStyle,
  }) : super(key: key);

  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<_CalendarPopupView> with TickerProviderStateMixin {
  late AnimationController animationController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }

    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: animationController.value,
              child: InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible!) Navigator.pop(context);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(4, 4), blurRadius: 8.0),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "From",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w100),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        startDate != null ? DateFormat("EEE, dd MMM").format(startDate!) : "--/-- ",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(width: 1, height: 74, color: Colors.grey[500]!.withOpacity(0.5)),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "To",
                                        style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w100),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        endDate != null ? DateFormat("EEE, dd MMM").format(endDate!) : "--/-- ",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(height: 1, color: Colors.grey[500]),
                            CustomCalendarView(
                              minimumDate: widget.minimumDate,
                              maximumDate: widget.maximumDate,
                              initialEndDate: widget.initialEndDate,
                              leftArrowColor: widget.leftArrowColor,
                              rightArrowColor: widget.rightArrowColor,
                              initialStartDate: widget.initialStartDate,
                              weekDaysTextColor: widget.weekDaysTextColor,
                              monthYearTextColor: widget.monthYearTextColor,
                              selectedRangeColor: widget.selectedRangeColor,
                              startEndDateChange: (DateTime? startDateData, DateTime? endDateData) {
                                setState(() {
                                  endDate = endDateData;
                                  startDate = startDateData;
                                });
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: DefaultButton(
                                      text: widget.cancelButtonText,
                                      margin: const EdgeInsets.all(0),
                                      btnColor: widget.cancelButtonColor,
                                      btnTextStyle: widget.cancelButtonTextStyle,
                                      onPressed: () {
                                        try {
                                          widget.onCancelClick!();
                                          Navigator.pop(context);
                                        } catch (e) {}
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: DefaultButton(
                                      text: widget.applyButtonText,
                                      margin: const EdgeInsets.all(0),
                                      btnColor: widget.applyButtonColor,
                                      btnTextStyle: widget.applyButtonTextStyle,
                                      onPressed: () {
                                        try {
                                          widget.onApplyClick!(startDate, endDate);
                                          Navigator.pop(context);
                                        } catch (e) {}
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
