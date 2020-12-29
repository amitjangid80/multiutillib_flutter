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
        title: 'multiutillib Demo',
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

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();
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
                Text(getCurrentDate()),
                const SizedBox(height: 10),
                Text(getCurrentDate(newDateTimeFormat: kDateDisplayFormat)),
                const SizedBox(height: 10),
                Text(getCurrentDate(newDateTimeFormat: kFullMonthYearFormat)),
                const SizedBox(height: 10),
                Text(getCurrentDate(newDateTimeFormat: kFullDateDisplayFormat)),
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
                    await showProgressDialog(context);

                    await Future.delayed(const Duration(seconds: 3));

                    await hideProgressDialog();
                  },
                ),
                const SizedBox(height: 10),
                LoadingWidget(itemCount: 1),
                OTPTextField(noOfOtpFields: 6),
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

    super.dispose();
  }
}
