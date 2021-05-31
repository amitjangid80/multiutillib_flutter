// Created by AMIT JANGID on 26/12/20.

import 'package:flutter/material.dart';
import 'package:multiutillib/widgets/material_card.dart';

import 'package:shimmer/shimmer.dart';

/// [LoadingWidget] This widget will show a loading effect for showing loading of data
/// This widget uses [Shimmer] widget from [shimmer] package
class LoadingWidget extends StatelessWidget {
  final int itemCount;
  final EdgeInsetsGeometry margin;
  final Color baseColor, highlightColor;

  LoadingWidget({
    this.itemCount = 6,
    this.highlightColor = Colors.white,
    this.baseColor = const Color(0xFFE0E0E0),
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, _position) {
        return MaterialCard(
          margin: margin,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(width: 50, height: 50, color: baseColor, padding: const EdgeInsets.all(10)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(color: baseColor, padding: const EdgeInsets.all(10)),
                        ),
                        const SizedBox(height: 10),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(color: baseColor, padding: const EdgeInsets.all(10)),
                        ),
                      ],
                    ),
                  ),
                ],
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
