// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [OTPTextField] this message will show OTP Fields for no of fields passed
class OTPTextField extends StatefulWidget {
  final int noOfOtpFields;
  final double borderWidth;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final EdgeInsetsGeometry margin;
  final Color cursorColor, borderColor;
  final bool isEnabled, autoFocus, autoCorrect;

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();

  OTPTextField({
    @required this.noOfOtpFields,
    this.borderWidth = 2,
    this.isEnabled = true,
    this.autoFocus = true,
    this.autoCorrect = false,
    this.borderColor = Colors.blue,
    this.cursorColor = Colors.blue,
    this.textAlign = TextAlign.center,
    this.margin = const EdgeInsets.only(top: 20, left: 20, right: 20),
    this.textStyle = const TextStyle(fontSize: 16, letterSpacing: 0.27, color: Colors.black),
  });
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode> _focusNodesList;
  List<String> _verificationCodeList;
  List<TextEditingController> _otpTextControllersList;

  @override
  void initState() {
    super.initState();

    _focusNodesList = List<FocusNode>(widget.noOfOtpFields);
    _verificationCodeList = List<String>(widget.noOfOtpFields);
    _otpTextControllersList = List<TextEditingController>(widget.noOfOtpFields);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Row(
        children: List.generate(widget.noOfOtpFields, (_position) {
          // calling add focus node to each text field method
          _addFocusNodeToEachTextField(position: _position);

          // calling add text editing controller to each text field method
          _addTextEditingControllerToEachTextField(position: _position);

          return Expanded(child: _otpTextFields(context: context, position: _position));
        }),
      ),
    );
  }

  _otpTextFields({@required int position, @required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        style: widget.textStyle,
        autofocus: widget.autoFocus,
        textAlign: widget.textAlign,
        autocorrect: widget.autoCorrect,
        cursorColor: widget.cursorColor,
        focusNode: _focusNodesList[position],
        controller: _otpTextControllersList[position],
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
        decoration: InputDecoration(
          border: UnderlineInputBorder(borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth),
          ),
        ),
        onChanged: (_input) {
          try {
            _verificationCodeList[position] = _input;

            // calling change focus to next node when value is entered
            _changeFocusToNextNodeWhenValueIsEntered(value: _input, position: position);
          } catch (e, s) {
            debugPrint('exception while adding otp to list: ${s.toString()}');
          }
        },
      ),
    );
  }

  void _addFocusNodeToEachTextField({@required int position}) {
    if (_focusNodesList[position] == null) {
      _focusNodesList[position] = FocusNode();
    }
  }

  void _addTextEditingControllerToEachTextField({@required int position}) {
    if (_otpTextControllersList[position] == null) {
      _otpTextControllersList[position] = TextEditingController();
    }
  }

  void _changeFocusToNextNodeWhenValueIsEntered({@required String value, @required int position}) {
    //only change focus to the next textField if the value entered has a length greater than one
    if (value.isNotEmpty) {
      //if the textField in focus is not the last textField,
      // change focus to the next textField
      if (position + 1 != widget.noOfOtpFields) {
        //change focus to the next textField
        FocusScope.of(context).requestFocus(_focusNodesList[position + 1]);
      }
    }
  }

  @override
  void dispose() {
    _focusNodesList.forEach((FocusNode _focusNode) => _focusNode.dispose());
    _otpTextControllersList.forEach((TextEditingController _controller) => _controller.dispose());

    super.dispose();
  }
}
