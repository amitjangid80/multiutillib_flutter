// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [OTPTextField] this message will show OTP Fields for no of fields passed
class OTPTextField extends StatefulWidget {
  /// no of otp fields to be generated
  final int noOfOtpFields;

  /// border width of the otp text field
  final double borderWidth;

  /// text style of the otp text field
  final TextStyle textStyle;

  /// text alignment for the otp text field
  final TextAlign textAlign;

  /// margin to be added for the entire otp text fields widget
  final EdgeInsetsGeometry margin;

  /// cursor color for otp text field
  final Color cursorColor;

  /// border color for otp text field
  final Color borderColor;

  /// to set auto focus of the value entered in otp text field
  final bool autoFocus;

  /// to set auto correction of the value entered in otp text field
  final bool autoCorrect;

  /// Callback function, called when pin is completed.
  final ValueChanged<String> onCompleted;

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();

  const OTPTextField({
    Key? key,
    required this.noOfOtpFields,
    required this.onCompleted,
    this.borderWidth = 2,
    this.autoFocus = true,
    this.autoCorrect = false,
    this.borderColor = Colors.blue,
    this.cursorColor = Colors.blue,
    this.textAlign = TextAlign.center,
    this.margin = const EdgeInsets.only(top: 15, left: 15, right: 15),
    this.textStyle =
        const TextStyle(fontSize: 16, letterSpacing: 0.27, color: Colors.black),
  })  : assert(noOfOtpFields > 1),
        super(key: key);
}

class _OTPTextFieldState extends State<OTPTextField> {
  late List<String> _otpList;
  late List<FocusNode?> _focusNodesList;
  late List<TextEditingController?> _otpTextControllersList;

  var _underlineInputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2));

  @override
  void initState() {
    super.initState();

    _focusNodesList = List.filled(widget.noOfOtpFields, null);
    _otpList = List.generate(widget.noOfOtpFields, (int i) => '');
    _otpTextControllersList = List.filled(widget.noOfOtpFields, null);

    _underlineInputBorder = UnderlineInputBorder(
      borderSide:
          BorderSide(color: widget.borderColor, width: widget.borderWidth),
    );
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

          return Expanded(
              child: _otpTextFields(context: context, position: _position));
        }),
      ),
    );
  }

  /// [_otpTextFields] method
  /// this method generates no of text fields for otp
  _otpTextFields({required int position, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        style: widget.textStyle,
        textAlign: widget.textAlign,
        autofocus: widget.autoFocus,
        autocorrect: widget.autoCorrect,
        cursorColor: widget.cursorColor,
        focusNode: _focusNodesList[position],
        controller: _otpTextControllersList[position],
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
        ],
        decoration: InputDecoration(
          border: _underlineInputBorder,
          focusedBorder: _underlineInputBorder,
          enabledBorder: _underlineInputBorder,
        ),
        onChanged: (_input) {
          try {
            if (_input.length > 1) {
              /// calling change focus to next node when value is entered
              _changeFocusToNextNodeWhenValueIsEntered(
                  value: _input, position: position);

              return;
            }

            /// calling change focus to previous node when value is empty
            _changeFocusToPreviousNodeWhenValueIsEmpty(
                value: _input, position: position);
          } catch (e, s) {
            debugPrint('exception while adding otp to list: ${s.toString()}');
          }
        },
      ),
    );
  }

  /// [_addFocusNodeToEachTextField] method
  /// this method adds focus nodes to otp text fields
  void _addFocusNodeToEachTextField({required int position}) {
    if (_focusNodesList[position] == null) {
      _focusNodesList[position] = FocusNode();
    }
  }

  /// [_addTextEditingControllerToEachTextField] method
  /// this method adds text editing controller to otp text fields
  void _addTextEditingControllerToEachTextField({required int position}) {
    if (_otpTextControllersList[position] == null) {
      _otpTextControllersList[position] = TextEditingController();
    }
  }

  /// [_changeFocusToPreviousNodeWhenValueIsEmpty] method
  /// this method will manage changing of focus to otp text field when value is entered
  void _changeFocusToPreviousNodeWhenValueIsEmpty(
      {required String value, required int position}) {
    /// Check if the current value at this position is empty
    /// If it is move focus to previous text field.
    if (value.isEmpty) {
      if (position == 0) return;

      _focusNodesList[position]!.unfocus();
      _focusNodesList[position - 1]!.requestFocus();

      _otpTextControllersList[position - 1]!.selection =
          TextSelection.fromPosition(
        TextPosition(
            offset: _otpTextControllersList[position - 1]!.value.text.length),
      );
    }

    /// Update the current pin
    setState(() => _otpList[position] = value);

    /// only change focus to the next textField if the value entered has a length greater than one
    if (value.isNotEmpty) {
      /// if the textField in focus is not the last textField,
      /// change focus to the next textField
      if (position + 1 != widget.noOfOtpFields) {
        /// change focus to the next textField
        FocusScope.of(context).requestFocus(_focusNodesList[position + 1]);
      }
    }

    // calling set entered otp method
    _setEnteredOtp();
  }

  /// [_changeFocusToNextNodeWhenValueIsEntered] method
  /// this method will manage changing of focus to otp text field when value is entered
  void _changeFocusToNextNodeWhenValueIsEntered(
      {required String value, required int position}) {
    if (value.length > widget.noOfOtpFields) {
      value = value.substring(0, widget.noOfOtpFields);
    }

    for (int i = 0; i < value.length; i++) {
      final String _otp = value.substring(i, i + 1);

      _otpList[i] = value;
      _otpTextControllersList[i]!.text = _otp;
    }

    // calling set entered otp method
    _setEnteredOtp();
  }

  /// [_getEnteredOtp] method
  /// this method will get entered otp from otp list
  String _getEnteredOtp() {
    String _otp = "";
    // _otpList.forEach((String value) => _otp += value);

    for (final String value in _otpList) {
      _otp += value;
    }

    return _otp;
  }

  void _setEnteredOtp() {
    /// calling get entered otp method
    final String _enteredOTP = _getEnteredOtp();

    /// if there are no null values that means otp is completed
    /// Call the `onCompleted` callback function provided
    if (!_otpList.contains(null) &&
        !_otpList.contains('') &&
        _enteredOTP.length == widget.noOfOtpFields) {
      widget.onCompleted(_enteredOTP);
    }
  }

  @override
  void dispose() {
    // _focusNodesList.forEach((FocusNode? _focusNode) => _focusNode!.dispose());
    // _otpTextControllersList.forEach((TextEditingController? _controller) => _controller!.dispose());

    for (int i = 0; i < _focusNodesList.length; i++) {
      _focusNodesList[i]!.dispose();
    }

    for (int i = 0; i < _otpTextControllersList.length; i++) {
      _otpTextControllersList[i]!.dispose();
    }

    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty('_underlineInputBorder', _underlineInputBorder));
  }
}
