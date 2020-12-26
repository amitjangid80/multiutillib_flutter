// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final bool isDescNewLine;
  final String caption, description;
  final TextStyle captionStyle, descriptionStyle;

  RichTextWidget({
    @required this.caption,
    @required this.description,
    this.isDescNewLine = false,
    this.captionStyle = const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
    this.descriptionStyle = const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: captionStyle,
        children: <TextSpan>[
          TextSpan(text: '$caption:${isDescNewLine ? '\n' : ' '}'),
          TextSpan(text: description, style: descriptionStyle),
        ],
      ),
    );
  }
}
