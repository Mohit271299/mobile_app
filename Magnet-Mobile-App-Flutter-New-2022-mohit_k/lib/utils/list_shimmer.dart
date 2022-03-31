import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class shimmer_list extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: 115,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Shimmer.fromColors(
              child: Container(
                height: 50,
                width: 50,
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
