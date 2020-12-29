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
debugPrint('formatting any date: ${formatDateTime('Date to format', newDateTimeFormat: 'Date Format to format the given date'}');
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
7. formatNumber({@required var numberToFormat, String customPattern = '##,###,###.##'}) // - returns formatted value
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
To use this widget you need to use [connectivity_wrapper](https://pub.dev/packages/connectivity_wrapper) package and wrap your ```dart MaterialApp ``` with ```dart ConnectivityAppWrapper ```.

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

### DefaultButton

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

### HyperLinkText

This is a widget to show a text and launch an url on click of the text.

Example:

```dart
HyperLinkText(url: 'http://www.google.com', text: 'Open Google'),
```

### LoadingWidget

This widget will show a loading shimmer effect.

Example:

```dart
LoadingWidget(
    itemCount = 6,
    highlightColor = Colors.white,
    baseColor = const Color(0xFFE0E0E0),
),
```

### MaterialCard

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

### OTPTextField

This widget is useful to take input for OTP while using OTP based login.

Example:

```dart
OTPTextField(
    @required int noOfOtpFields,
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

### RichTextWidget

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