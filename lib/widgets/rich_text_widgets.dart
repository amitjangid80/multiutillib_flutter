// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/material.dart';

/// [RichTextWidget] This widget will show text in single or new line in caption description format
/// This widget uses [RichText] widget
class RichTextWidget extends StatelessWidget {
  final TextAlign textAlign;
  final String caption, description;
  final bool showColon, isDescNewLine;
  final TextStyle captionStyle, descriptionStyle;

  const RichTextWidget({
    required this.caption,
    required this.description,
    this.showColon = true,
    this.isDescNewLine = false,
    this.textAlign = TextAlign.start,
    this.captionStyle = const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
    this.descriptionStyle = const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: '$caption${showColon ? ':' : ''}${isDescNewLine ? '\n' : ' '}', style: captionStyle),
          TextSpan(text: description, style: descriptionStyle),
        ],
      ),
    );
  }
}
