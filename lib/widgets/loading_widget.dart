// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/material.dart';
import 'package:multiutillib/widgets/material_card.dart';

import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final int itemCount;
  final Color baseColor, highlightColor;

  LoadingWidget({
    this.itemCount = 6,
    this.highlightColor = Colors.white,
    this.baseColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (context, _position) {
        return MaterialCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(color: baseColor, width: _width * 0.50, padding: const EdgeInsets.all(10)),
              ),
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  color: baseColor,
                  width: _width * 0.60,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                ),
              ),
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  color: baseColor,
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                ),
              ),
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  color: baseColor,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
