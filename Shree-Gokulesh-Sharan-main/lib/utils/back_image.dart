// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:vaishnav_parivar/utils/asset_utils.dart';

class back_image extends StatelessWidget{
  final Widget body_container;
  const back_image({Key? key, required this.body_container}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetUtils.back_png),
            fit: BoxFit.fill
          ),
        ),
        child: body_container,
      ),
    );
  }

}