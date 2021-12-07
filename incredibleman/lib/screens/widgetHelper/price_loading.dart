import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PriceLoading extends StatelessWidget {
  const PriceLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 20,
        width: 65,
        color: Colors.red,
      ),
    );
  }
}
