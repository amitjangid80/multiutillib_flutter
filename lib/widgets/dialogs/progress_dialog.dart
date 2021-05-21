// Created by AMIT JANGID on 19/08/20.

import 'package:flutter/material.dart';

import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog _progressDialog;

/// show progress dialog method
///
/// this method will show progress dialog
/// Uses [ProgressDialog] from [progress_dialog] package
showProgressDialog(BuildContext context, {String message = 'Please wait...', Widget progressWidget}) async {
  _progressDialog = ProgressDialog(context, isDismissible: false, type: ProgressDialogType.Normal);

  _progressDialog.style(
    message: message,
    progressWidget: progressWidget ?? Padding(child: progressWidget, padding: const EdgeInsets.all(10)),
  );

  await _progressDialog.show();
}

/// hide progress dialog method
///
/// this method will hide progress dialog
/// Uses [ProgressDialog] from [progress_dialog] package
hideProgressDialog() async {
  if (_progressDialog != null) {
    await _progressDialog.hide();
  }
}
