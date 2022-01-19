// Created by AMIT JANGID on 17/12/20.

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

/// This widget will display a text in hyper link format
/// This widget uses [launch] method from [url_launcher] package
class HyperLinkText extends StatelessWidget {
  final String url, text;
  final EdgeInsetsGeometry padding;

  const HyperLinkText(
      {Key? key,
      this.padding = const EdgeInsets.all(12),
      required this.url,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchUrl,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)
              .copyWith(
                  color: Colors.blue, decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  _launchUrl() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('cannot launch url $url');
    }
  }
}
