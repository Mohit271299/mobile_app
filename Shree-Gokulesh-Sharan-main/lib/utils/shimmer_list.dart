import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vaishnav_parivar/utils/color_utils.dart';

class shimmer_list extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context , int index) {
        return Container(
            height: 215,
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
              highlightColor: ColorUtils.primary.withOpacity(0.1),
            )
        );
      }
    );
  }

}
