// Created by AMIT JANGID on 19/08/20.

import 'package:flutter/material.dart';

import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog _progressDialog;

/// 2020 September 17 - Thursday
/// show progress dialog method
///
/// this method will show progress dialog
/// Uses [ProgressDialog] from [progress_dialog] package
showProgressDialog(BuildContext context, {String message = 'Please wait...', Widget progressWidget}) async {
  _progressDialog = ProgressDialog(context, isDismissible: false, type: ProgressDialogType.Normal);
  _progressDialog.style(progressWidget: progressWidget, message: message);

  await _progressDialog.show();
}

/*
 * 2020 September 17 - Thursday
 * hide progress dialog method
 *
 * this method will hide progress dialog
**/
hideProgressDialog() async {
  if (_progressDialog != null) {
    await _progressDialog.hide();
  }
}
