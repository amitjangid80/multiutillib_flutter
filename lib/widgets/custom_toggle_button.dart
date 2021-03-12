// Created by AMIT JANGID on 12/03/21.

import 'package:flutter/material.dart';

import 'package:multiutillib/widgets/material_card.dart';

class CustomToggleButton extends StatefulWidget {
  final int transitionTime;
  final String textOn, textOff;
  final Function(String value) onChanged;
  final double width, height, borderRadius;
  final Color activeSwitchColor, inactiveSwitchColor, activeTextColor, inactiveTextColor;

  CustomToggleButton({
    @required this.textOn,
    @required this.textOff,
    @required this.onChanged,
    this.width = 200,
    this.height = 45,
    this.borderRadius = 50,
    this.transitionTime = 300,
    this.activeTextColor = Colors.black,
    this.activeSwitchColor = Colors.white,
    this.inactiveTextColor = Colors.white,
    this.inactiveSwitchColor = Colors.blue,
  });

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

const double _textOnAlign = -1;
const double _textOffAlign = 1;

class _CustomToggleButtonState extends State<CustomToggleButton>
    with AutomaticKeepAliveClientMixin<CustomToggleButton> {
  double _xAlign;
  String _selectedValue;

  @override
  void initState() {
    super.initState();

    setState(() {
      _xAlign = _textOnAlign;
      _selectedValue = widget.textOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MaterialCard(
      elevation: 2,
      borderRadius: 50,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.inactiveSwitchColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(_xAlign, 0),
              duration: Duration(milliseconds: widget.transitionTime),
              child: MaterialCard(
                elevation: 2,
                color: widget.activeSwitchColor,
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(0),
                borderRadius: widget.borderRadius,
                child: Container(height: widget.height, width: widget.width * 0.5),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.onChanged(widget.textOn);

                setState(() {
                  _xAlign = _textOnAlign;
                  _selectedValue = widget.textOn;
                });
              },
              child: Align(
                alignment: Alignment(-1, 0),
                child: Container(
                  width: widget.width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedValue == widget.textOn ? widget.activeTextColor : widget.inactiveTextColor,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.onChanged(widget.textOff);

                setState(() {
                  _xAlign = _textOffAlign;
                  _selectedValue = widget.textOff;
                });
              },
              child: Align(
                alignment: Alignment(1, 0),
                child: Container(
                  width: widget.width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.textOff,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedValue == widget.textOff ? widget.activeTextColor : widget.inactiveTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
