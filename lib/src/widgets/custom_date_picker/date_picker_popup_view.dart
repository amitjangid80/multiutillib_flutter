import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:multiutillib/src/widgets/default_button.dart';
import 'package:multiutillib/src/widgets/custom_date_picker/date_picker_calendar_view.dart';

showCustomDatePicker({
  required BuildContext context,
  required Function onCancelClick,
  String applyButtonText = 'Apply',
  String cancelButtonText = 'Cancel',
  Color leftArrowColor = Colors.blue,
  Color rightArrowColor = Colors.blue,
  Color applyButtonColor = Colors.blue,
  Color cancelButtonColor = Colors.red,
  Color weekDaysTextColor = Colors.blue,
  Color selectedDateColor = Colors.blue,
  Color monthYearTextColor = Colors.black,
  required Function(DateTime? dateTime)? onApplyClick,
  TextStyle applyButtonTextStyle = const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
  TextStyle cancelButtonTextStyle = const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
  DateTime? minimumDate,
  DateTime? maximumDate,
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
      leftArrowColor: leftArrowColor,
      rightArrowColor: rightArrowColor,
      applyButtonText: applyButtonText,
      cancelButtonText: cancelButtonText,
      applyButtonColor: applyButtonColor,
      cancelButtonColor: cancelButtonColor,
      weekDaysTextColor: weekDaysTextColor,
      monthYearTextColor: monthYearTextColor,
      selectedDateColor: selectedDateColor,
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
  final Function(DateTime?)? onApplyClick;
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
  final Color? selectedDateColor;

  const _CalendarPopupView({
    this.minimumDate,
    this.maximumDate,
    this.barrierDismissible,
    this.initialStartDate,
    this.onApplyClick,
    this.onCancelClick,
    this.applyButtonText,
    this.cancelButtonText,
    this.applyButtonColor,
    this.cancelButtonColor,
    this.applyButtonTextStyle,
    this.cancelButtonTextStyle,
    this.weekDaysTextColor,
    this.monthYearTextColor,
    this.leftArrowColor,
    this.rightArrowColor,
    this.selectedDateColor,
  });

  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<_CalendarPopupView> with TickerProviderStateMixin {
  late AnimationController animationController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      endDate = widget.initialStartDate;
      startDate = widget.initialStartDate;
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
              duration: const Duration(milliseconds: 100),
              opacity: animationController.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible!) Navigator.pop(context);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(4, 4), blurRadius: 8.0),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomCalendarView(
                              minimumDate: widget.minimumDate,
                              maximumDate: widget.maximumDate,
                              leftArrowColor: widget.leftArrowColor,
                              rightArrowColor: widget.rightArrowColor,
                              initialStartDate: widget.initialStartDate,
                              weekDaysTextColor: widget.weekDaysTextColor,
                              selectedDateColor: widget.selectedDateColor,
                              monthYearTextColor: widget.monthYearTextColor,
                              onDateChange: (DateTime? startDateData) => setState(() => startDate = startDateData),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        } catch (e) {
                                          debugPrint('exception in on cancel click method');
                                        }
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
                                          widget.onApplyClick!(startDate);
                                        } catch (e) {
                                          debugPrint('exception in on apply click method');
                                        }
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
