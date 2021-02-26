# multiutillib

A flutter package to help with utilities, animations and some pre-built widgets.
Some widgets are with default values for direct use and you can still customize according to your needs.

This package used following packages:
1. [intl](https://pub.dev/packages/intl)
2. [shimmer](https://pub.dev/packages/shimmer)
3. [device_info](https://pub.dev/packages/device_info)
4. [url_launcher](https://pub.dev/packages/url_launcher)
5. [package_info](https://pub.dev/packages/package_info)
6. [progress_dialog](https://pub.dev/packages/progress_dialog)
7. [simple_animations](https://pub.dev/packages/simple_animations)
8. [connectivity_wrapper](https://pub.dev/packages/connectivity_wrapper)

## Examples

## FadeAnimation

This widget will help a child widget to perform a fade animation.
[FadeAnimation] (lib/animations/fade_animation.dart) requires two parameters delay and child.
The delay is animation delay to be performed.

Example of FadeAnimation:

```dart
FadeAnimation(
    delay: 1,
    child: Container(),
),
```

## SlideAnimation

This widget will help a child widget to perform a slide animation from Top, Left, Right or Bottom direction.
[SlideAnimation] (lib/animations/slide_animation.dart) required 5 parameters child, itemCount, position, slideDirection and animationController.
This widget will help in animating items of list view.

There is enum to help choose direction of slide animation.

Example of SlideAnimation:

```dart
SlideAnimation(
    child: child,
    position: position,
    itemCount: itemCount,
    slideDirection: SlideDirection.fromRight,
    animationController: animationController,
),
```

## DateTimeUtils

This is a utility class which will help in getting current date in format 'yyyy-MM-dd HH:mm:ss' or date format passed.
This class will also help in formatting date in any valid format like 'dd-MM-yyyy' or 'dd/MM/yyyy' or any other you want.

Example of DateTimeUtils:

```dart
debugPrint('current date is: ${getCurrentDate()}');
```

There is extension methods which can be used to display date, time in provided or default format

Example:

```dart
// Convert time String to Duration Object
'01:01:01'.toDuration;

// Convert Date String to Date Time Object
'20210226'.toDateTime;
'2021-02-26'.toDateTime;
'20210226 140652.55'.toDateTime
'2021-02-26 14:06:52.55'.toDateTime

// Convert Date Time to Date Time String for display
DateTime.now().formatDateTime(newDateTimeFormat: 'dd-MM-yyyy hh:mm a');

// Convert Date Time String to Date Time String for display
DateTime.now().formatDateTime();

// getCurrentDate() returns date time string
getCurrentDate().formatDateTime(newDateTimeFormat: 'dd-MM-yyyy');

// Convert Time of Day to Time String for display
TimeOfDay.now().formatTime();

// Convert Time of Day String to Time String for display
'14:39'.formatTime();

// Convert Time String to Time Of Day Object
'14:39'.toTimeOfDay

// Convert Date Time to Time of Day Object
DateTime.now().toTimeOfDay
```

## Utils

This is a utility class which will help in getting device name, device id, managing null values in strings.

```dart
1. getDeviceName() // - returns future string
2. getDeviceId() // - returns future string
3. replaceNullWithEmpty(String to be replace) // - returns string value or empty string
4. replaceNullWithZero(String to be replace) // - returns integer value or zero
5. replaceNullWithDouble(String to be replace) // - returns double value or zero
6. replaceTrueOrFalse(String to be replace) // - returns 1 for true value or 0 for false value
7. formatNumber({numberToFormat, customPattern = '##,###,###.##'}) // - returns formatted value
8. isNumeric(StringToCheck) // - returns true or false if string passed is numeric
9. getSingleDigitRandomNumber() // - returns single digit randomly
10. getRandomNumber(min: MinValue, max: MaxValue) // - returns randomly generated number between min and max value
11. getRandomMobileNumber() // - returns randomly generated mobile number
12. getCharFromString(stringToExtract) // - returns only characters from string passed
13. getNumbersFromString(stringToExtract) // - returns only digits from string passed
14. getAppVersion() // - return current version of the app
```

## Extensions

Some of the Utils method can now be used as extensions.

Example:

```dart
// Checking if a string or int or double value is numeric or not
123.isNumeric => returns true
'123'.isNumeric => returns true
'String'.isNumeric => returns false

Text('Format Number: ' + 1010.869.formatNumber()),
Text('Replace Null With Empty: ' + null.replaceNullWithEmpty)
Text('Replace True or False: ' + true.replaceTrueOrFalse.toString()),
Text('Replace Null With Zero: ' + null.replaceNullWithZero.toString()),
Text('Replace Null with Double: ' + null.replaceNullWithDouble.toString()),
```

## ShowConfirmationDialog

This method will show a confirmation dialog box with two button to ask for confirmation.

Example:

```dart
showConfirmationDialog(
    BuildContext context,
    Widget transitionAnimation,
    String negativeBtnText 'No',
    String positiveBtnText: 'Yes',
    bool barrierDismissible: false,
    Color dividerColor = Colors.blue,
    Color positiveBtnColor = Colors.blue,
    Color negativeBtnColor = Colors.blueAccent,
    TextAlign descTextAlign = TextAlign.center,
    TextAlign titleTextAlign = TextAlign.center,
    Duration transitionDuration = const Duration(milliseconds: 400),
    DialogAnimationType dialogAnimationType = DialogAnimationType.grow,
    TextStyle descStyle = const TextStyle(fontSize: 16, letterSpacing: 0.27, color: Colors.black),
    TextStyle titleStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.bold),
    TextStyle positiveBtnStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.w400),
    TextStyle negativeBtnStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.w400),
    @required String title,
    @required String description,
    @required VoidCallback onPositivePressed,
);
```

## ShowCustomDialog

This method will show a dialog box with single button to show warning or info or success or error.

Example:

```dart
showCustomDialog(
  BuildContext context,
  String btnText = 'OK',
  Color btnColor = Colors.blue,
  bool barrierDismissible: false,
  Color dividerColor = Colors.blue,
  TextAlign descTextAlign = TextAlign.center,
  TextAlign titleTextAlign = TextAlign.center,
  Duration transitionDuration = const Duration(milliseconds: 400),
  DialogAnimationType dialogAnimationType = DialogAnimationType.grow,
  TextStyle descStyle = const TextStyle(fontSize: 16, letterSpacing: 0.27, color: Colors.black),
  TextStyle btnStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.w400),
  TextStyle titleStyle = const TextStyle(fontSize: 18, letterSpacing: 0.27, fontWeight: FontWeight.bold),
  @required String title,
  @required String description,
);
```

## ProgressDialog

This class will help in showing and hiding progress dialog with custom loading widget.

Example:

```dart
// For Showing Progress Dialog
await showProgressDialog(context);

// For hiding Progress Dialog
await hideProgressDialog();
```

## ConnectivityLayout

This is widget to show connectivity message like Internet Connection not available.
To use this widget you need to use [connectivity_wrapper](https://pub.dev/packages/connectivity_wrapper) package and wrap your ```MaterialApp``` with ```ConnectivityAppWrapper```.

Example:

```dart
ConnectivityLayout(
    @required Widget child,
    this.bgColor = Colors.red,
    this.disableInteraction = false,
    this.alignment = Alignment.bottomCenter,
    this.message = 'Internet Connection not Available.',
    this.messageStyle = const TextStyle(color: Colors.white),
),
```

## DefaultButton

This is a button widget. See example for using this widget

Example:

```dart
DefaultButton(
    isEnabled = true,
    borderRadius = 24,
    isUpperCase = true,
    margin = const EdgeInsets.only(top: 20),
    @required String text,
    @required Function onPressed,
),
```

## HyperLinkText

This is a widget to show a text and launch an url on click of the text.

Example:

```dart
HyperLinkText(url: 'http://www.google.com', text: 'Open Google'),
```

## LoadingWidget

This widget will show a loading shimmer effect.

Example:

```dart
LoadingWidget(
    itemCount = 6,
    highlightColor = Colors.white,
    baseColor = const Color(0xFFE0E0E0),
),
```

## MaterialCard

This widget is useful in showing card view. You can use it directly or customize according to your needs.
You can pass either borderRadius parameter value or borderRadiusGeometry parameter value.

Example:

```dart
MaterialCard(
    @required Widget child,
    onTap,
    borderRadius,
    elevation = 4,
    borderRadiusGeometry,
    color = Colors.white,
    padding = const EdgeInsets.all(12),
    margin = const EdgeInsets.only(top: 12),
),
```

## OTPTextField

This widget is useful to take input for OTP while using OTP based login.

Example:

```dart
OTPTextField(
    @required int noOfOtpFields,
    @required ValueChanged<String> onCompleted,
    borderWidth = 2,
    isEnabled = true,
    autoFocus = true,
    autoCorrect = false,
    borderColor = Colors.blue,
    cursorColor = Colors.blue,
    textAlign = TextAlign.center,
    margin = const EdgeInsets.only(top: 20, left: 20, right: 20),
    textStyle = const TextStyle(fontSize: 16, letterSpacing: 0.27, color: Colors.black),
),
```

## RichTextWidget

This widget is helpful in showing caption and description value in single line or caption on top and description in new line.

Example:

```dart
RichTextWidget(
    @required String caption,
    @required String description,
    isDescNewLine = false,
    captionStyle = const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
    descriptionStyle = const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
),
```

## DecimalInputFormatter

This is an [TextInputFormatter] for [TextField] for allowing to enter only allowed decimal range

Example:
```dart
// [DecimalInputFormatter] will allow only entered decimal range for the string in text field
TextFormField(
  inputFormatters: [DecimalInputFormatter(decimalRange: 2)],
  decoration: InputDecoration(labelText: 'Enter Decimal values'),
),
```

## Validators

This class has validation method for validating string

1. Email Validator - This will check and validate if the entered string is a valid email id

Example:

```dart
TextFormField(
  // this method will validate for email id
  validator: emailValidator,
  decoration: InputDecoration(labelText: 'Enter Email Id'),
),
```
