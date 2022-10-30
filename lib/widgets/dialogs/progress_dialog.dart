// Created by AMIT JANGID on 19/08/20.

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multiutillib/enums/progress_dialog_type.dart';

/// show progress dialog method
///
/// this method will show progress dialog
/// Uses [_ProgressDialog] class
showProgressDialog(BuildContext context, {String message = 'Please wait...', Widget? progressWidget}) async {
  _context = context;
  _progressDialog = _ProgressDialog(context, isDismissible: false, type: ProgressDialogType.normal);

  _progressDialog!.style(
    message: message,
    size: progressWidget != null ? 40.0 : 60.0,
    padding: EdgeInsets.all(progressWidget != null ? 12.0 : 8.0),
    progressWidget: progressWidget /* ?? Image(image: AssetImage('assets/gif/double_ring_loading_io.gif'))*/,
  );

  await _progressDialog!.show();
}

showInkDropProgressDialog(BuildContext context, {String message = 'Please wait...'}) async {
  _context = context;
  _progressDialog = _ProgressDialog(context, isDismissible: false, type: ProgressDialogType.normal);

  _progressDialog!.style(
    size: 40,
    message: message,
    padding: const EdgeInsets.all(12),
    progressWidget: LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 40),
  );

  await _progressDialog!.show();
}

/// hide progress dialog method
///
/// this method will hide progress dialog
/// Uses [_ProgressDialog] from [progress_dialog] package
hideProgressDialog() async {
  if (_progressDialog != null) {
    await _progressDialog!.hide();
  }
}

String _dialogMessage = "Please wait...";
double _size = 60.0, _progress = 0.0, _maxProgress = 100.0;

Widget? _customBody;
_ProgressDialog? _progressDialog;

TextAlign _textAlign = TextAlign.left;
TextDirection _direction = TextDirection.ltr;
Alignment _progressWidgetAlignment = Alignment.centerLeft;

bool _isShowing = false;
ProgressDialogType? _progressDialogType;
late BuildContext? _context, _dismissingContext;
bool _barrierDismissible = true, _showLogs = false;

TextStyle _progressTextStyle = const TextStyle(
  fontSize: 12.0,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

TextStyle _messageStyle = const TextStyle(
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);

Color _backgroundColor = Colors.white;
Curve _insetAnimCurve = Curves.easeInOut;
double _dialogElevation = 8.0, _borderRadius = 8.0;
EdgeInsets _dialogPadding = const EdgeInsets.all(8.0);

Widget _progressWidget = Image.asset('assets/gif/double_ring_loading_io.gif', package: "multiutillib");

class _ProgressDialog {
  // _Body? _dialog;

  _ProgressDialog(
    BuildContext context, {
    ProgressDialogType? type,
    bool? isDismissible,
    bool? showLogs,
    TextDirection? textDirection,
    Widget? customBody,
  }) {
    _context = context;
    _progressDialogType = type ?? ProgressDialogType.normal;
    _barrierDismissible = isDismissible ?? true;
    _showLogs = showLogs ?? false;
    _customBody = customBody;
    _direction = textDirection ?? TextDirection.ltr;
  }

  void style({
    double? size,
    Widget? child,
    double? progress,
    double? maxProgress,
    String? message,
    Widget? progressWidget,
    Color? backgroundColor,
    TextStyle? progressTextStyle,
    TextStyle? messageTextStyle,
    double? elevation,
    TextAlign? textAlign,
    double? borderRadius,
    Curve? insetAnimCurve,
    EdgeInsets? padding,
    Alignment? progressWidgetAlignment,
  }) {
    if (_isShowing) return;

    if (_progressDialogType == ProgressDialogType.download) {
      _progress = progress ?? _progress;
    }

    _size = size ?? _size;
    _dialogMessage = message ?? _dialogMessage;
    _maxProgress = maxProgress ?? _maxProgress;
    _progressWidget = progressWidget ?? _progressWidget;
    _backgroundColor = backgroundColor ?? _backgroundColor;
    _messageStyle = messageTextStyle ?? _messageStyle;
    _progressTextStyle = progressTextStyle ?? _progressTextStyle;
    _dialogElevation = elevation ?? _dialogElevation;
    _borderRadius = borderRadius ?? _borderRadius;
    _insetAnimCurve = insetAnimCurve ?? _insetAnimCurve;
    _textAlign = textAlign ?? _textAlign;
    _progressWidget = child ?? _progressWidget;
    _dialogPadding = padding ?? _dialogPadding;
    _progressWidgetAlignment = progressWidgetAlignment ?? _progressWidgetAlignment;
  }

  void update({
    double? progress,
    double? maxProgress,
    String? message,
    Widget? progressWidget,
    TextStyle? progressTextStyle,
    TextStyle? messageTextStyle,
  }) {
    if (_progressDialogType == ProgressDialogType.download) {
      _progress = progress ?? _progress;
    }

    _dialogMessage = message ?? _dialogMessage;
    _maxProgress = maxProgress ?? _maxProgress;
    _progressWidget = progressWidget ?? _progressWidget;
    _messageStyle = messageTextStyle ?? _messageStyle;
    _progressTextStyle = progressTextStyle ?? _progressTextStyle;

    if (_isShowing) _BodyState().update();
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(_dismissingContext!).pop();

        if (_showLogs) debugPrint('ProgressDialog dismissed');

        return Future.value(true);
      } else {
        if (_showLogs) debugPrint('ProgressDialog already dismissed');

        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());

      return Future.value(false);
    }
  }

  Future<bool> show() async {
    try {
      if (!_isShowing) {
        showDialog<dynamic>(
          context: _context!,
          barrierDismissible: _barrierDismissible,
          builder: (BuildContext context) {
            _dismissingContext = context;
            return WillPopScope(
              onWillPop: () async => _barrierDismissible,
              child: Dialog(
                elevation: _dialogElevation,
                backgroundColor: _backgroundColor,
                insetAnimationCurve: _insetAnimCurve,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
                child: _Body(),
              ),
            );
          },
        );

        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(const Duration(milliseconds: 200));

        if (_showLogs) debugPrint('ProgressDialog shown');
        _isShowing = true;

        return true;
      } else {
        if (_showLogs) debugPrint("ProgressDialog already shown/showing");

        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());

      return false;
    }
  }
}

class _Body extends StatefulWidget {
  /*final _BodyState _dialog = _BodyState();

  update() {
    _dialog.update();
  }*/

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  update() {
    setState(() {});
  }

  @override
  void dispose() {
    _isShowing = false;

    if (_showLogs) debugPrint('ProgressDialog dismissed by back button');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loader = Align(
      alignment: _progressWidgetAlignment,
      child: SizedBox(width: _size, height: _size, child: _progressWidget),
    );

    final text = Expanded(
      child: _progressDialogType == ProgressDialogType.normal
          ? Text(_dialogMessage, style: _messageStyle, textAlign: _textAlign, textDirection: _direction)
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Expanded(child: Text(_dialogMessage, style: _messageStyle, textDirection: _direction)),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text("$_progress/$_maxProgress", style: _progressTextStyle, textDirection: _direction),
                  ),
                ],
              ),
            ),
    );

    return _customBody ??
        Container(
          padding: _dialogPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // row body
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 8.0),
                  if (_direction == TextDirection.ltr) loader else text,
                  const SizedBox(width: 16.0),
                  if (_direction == TextDirection.rtl) loader else text,
                  const SizedBox(width: 8.0),
                ],
              ),
            ],
          ),
        );
  }
}
