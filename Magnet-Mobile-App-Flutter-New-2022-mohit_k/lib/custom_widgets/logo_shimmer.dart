import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class shimmer_logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
        height: 270,
        margin: EdgeInsets.symmetric(vertical: 42,horizontal: 57),
        child: Shimmer.fromColors(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          period: Duration(seconds: 2),
          baseColor: Colors.black.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.1),
        )
    );
  }

}
