import 'package:flutter/material.dart';

import 'package:multiutillib/multiutillib.dart';
import 'package:multiutillib/enums/dialog_animation_type.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        home: MyHomePage(),
        title: 'multiutillib Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  TextEditingController _textEditingController = TextEditingController();

  String _isValid = '* Email Id is required.';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();

    _textEditingController.addListener(() {
      final _isEmailValid = emailValidator(_textEditingController.value.text);

      if (_isEmailValid != _isValid) {
        setState(() => _isValid = _isEmailValid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text('Multi Util Lib')),
      body: ConnectivityLayout(
        child: MaterialCard(
          borderRadius: 15,
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                CustomToggleButton(textOn: 'On', textOff: 'Off', onChanged: (_value) => debugPrint('$_value')),
                const SizedBox(height: 10),
                OffsetAnimation(
                  end: 20,
                  animationController: _animationController,
                  widget: Container(height: 100, color: Colors.black12, width: double.infinity),
                ),
                const SizedBox(height: 10),
                Text('Get Current Date: ' + getCurrentDate()),
                const SizedBox(height: 10),
                Text(
                  'Get Current Date in $kDateDisplayFormat Format: \n' +
                      getCurrentDate(newDateTimeFormat: kDateDisplayFormat),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Get Current Date in $kFullMonthYearFormat Format: \n' +
                      getCurrentDate(newDateTimeFormat: kFullMonthYearFormat),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Get Current Date in $kFullDateDisplayFormat Format: \n' +
                      getCurrentDate(newDateTimeFormat: kFullDateDisplayFormat),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Format Date Time in dd-MM-yyyy format: \n' +
                      getCurrentDate().formatDateTime(newDateTimeFormat: 'dd-MM-yyyy'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Formatting Date Time Object in dd-MM-yyyy format: \n' +
                      DateTime.now().formatDateTime(newDateTimeFormat: 'dd-MM-yyyy HH:mm'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Convert to Date Time Object: \n' + '2021-02-26 14:06:52.55'.toDateTime.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Convert Time of Day to String: \n' + TimeOfDay.now().formatTime(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Convert Time of Day String to String: \n' + '14:39'.formatTime(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Convert Time String to Time of Day: \n' + '14:39'.toTimeOfDay.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Convert DateTime to Time of Day: \n' + DateTime.now().toTimeOfDay.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Convert DateTime to String: \n' + DateTime.now().formatDateTime(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text('Replace Null With Empty: ' + "null".replaceNullWithEmpty),
                const SizedBox(height: 10),
                Text('Replace Null With Zero: ' + "null".replaceNullWithZero.toString()),
                const SizedBox(height: 10),
                Text('Replace True or False: ' + "true".replaceTrueOrFalse.toString()),
                const SizedBox(height: 10),
                Text('Replace Null with Double: ' + "null".replaceNullWithDouble.toString()),
                const SizedBox(height: 10),
                Text('Format Number: ' + "1010.869".formatNumber()),
                const SizedBox(height: 10),
                Text('Format Number to Compact: ' + '88944444'.formatNumberToCompact),
                const SizedBox(height: 10),
                Text('Is Numeric: ' + "1".isNumeric.toString()),
                const SizedBox(height: 10),
                Text('To Duration: ' + '01:01:01'.toDuration.toString()),
                const SizedBox(height: 10),
                Text('From Duration: ' + '16:35:34'.toDuration.toTimeString(newTimeString: 'mm:ss')),
                const SizedBox(height: 10),
                Text('To Two Digit: ${"9".toTwoDigits}'),
                const SizedBox(height: 10),
                Text('To Three Digit: ${"9".toThreeDigits}'),
                const SizedBox(height: 10),
                Text('To Length of String: ${'9'.toLengthOfString(5)}'),
                const SizedBox(height: 10),
                // [DecimalInputFormatter] will allow only entered decimal range for the string in text field
                TextFormField(
                  inputFormatters: [DecimalInputFormatter(decimalRange: 2)],
                  decoration: InputDecoration(labelText: 'Enter Decimal values'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  // this method will validate for email id
                  validator: emailValidator,
                  controller: _textEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(errorText: _isValid, labelText: 'Enter Email Id'),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: getDeviceName(),
                  builder: (context, snapshot) {
                    debugPrint('snapshot data is: ${snapshot.data}');

                    if (snapshot.hasData) return Text(snapshot.data);

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: getDeviceId(),
                  builder: (context, snapshot) {
                    debugPrint('snapshot data is: ${snapshot.data}');

                    if (snapshot.hasData) return Text(snapshot.data);

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 10),
                HyperLinkText(url: 'http://www.google.com', text: 'Open Google'),
                DefaultButton(
                  text: 'Show Date Range Picker',
                  margin: const EdgeInsets.only(top: 10),
                  onPressed: () {
                    showCustomDateRangePicker(
                      context: context,
                      onCancelClick: () {},
                      onApplyClick: (startDate, enDate) {},
                    );
                  },
                ),
                DefaultButton(
                  text: 'Show Date Picker',
                  margin: const EdgeInsets.only(top: 10),
                  onPressed: () {
                    showCustomDatePicker(
                      context: context,
                      onCancelClick: () {},
                      onApplyClick: (selectedDate) {},
                    );
                  },
                ),
                DefaultButton(
                  text: 'Show Custom Dialog',
                  margin: const EdgeInsets.only(top: 10),
                  onPressed: () {
                    showCustomDialog(
                      context,
                      title: 'Custom Dialog',
                      btnColor: Colors.green,
                      dialogAnimationType: DialogAnimationType.fromBottom,
                      description: 'This is a test to show custom dialog',
                    );
                  },
                ),
                DefaultButton(
                  text: 'Show Confirmation Dialog',
                  margin: const EdgeInsets.only(top: 10),
                  onPressed: () {
                    showConfirmationDialog(
                      context,
                      dividerColor: Colors.black,
                      title: 'Confirmation Dialog',
                      positiveBtnColor: Colors.green,
                      negativeBtnColor: Colors.greenAccent,
                      onPositivePressed: () => Navigator.pop(context),
                      dialogAnimationType: DialogAnimationType.fromLeft,
                      description: 'This is a test to show confirmation dialog',
                    );
                  },
                ),
                DefaultButton(
                  text: 'Show Progress Dialog',
                  margin: const EdgeInsets.only(top: 10),
                  onPressed: () async {
                    // calling show progress dialog method
                    await showProgressDialog(context, /*progressWidget: const CircularProgressIndicator()*/);

                    await Future.delayed(const Duration(seconds: 3));

                    await hideProgressDialog();
                  },
                ),
                const SizedBox(height: 10),
                LoadingWidget(itemCount: 1),
                OTPTextField(
                  autoFocus: false,
                  noOfOtpFields: 6,
                  onCompleted: (_enteredOtp) => debugPrint('entered otp is: $_enteredOtp'),
                ),
                const SizedBox(height: 10),
                RichTextWidget(
                  caption: 'Rich',
                  description: 'Text',
                  captionStyle: TextStyle(fontSize: 20, color: Colors.black),
                  descriptionStyle: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textEditingController.dispose();

    super.dispose();
  }
}
