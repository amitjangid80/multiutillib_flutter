// Created By Amit Jangid 14/07/21

import 'package:flutter/material.dart';

class NoRecordsFound extends StatelessWidget {
  const NoRecordsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Records Found',
        style: TextStyle(fontSize: 18, letterSpacing: 0.10, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}
