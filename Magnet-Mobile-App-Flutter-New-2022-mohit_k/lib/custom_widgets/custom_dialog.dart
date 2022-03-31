// import 'package:flutter/material.dart';
//
// test({required String title, required BuildContext context}) =>
//     showGeneralDialog(
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionBuilder: (context, a1, a2, widget) {
//         return Transform.scale(
//           scale: a1.value,
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               shape:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
//               title: Text(title.toString()),
//               content: Text('How are you?'),
//             ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context, pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {  },
//     );
//
// class custom_dialog extends StatelessWidget {
//   const custom_dialog({Key? key}) : super(key: key);
//
//   Future openDialog(context) {
//     return showGeneralDialog(
//         barrierColor: Colors.black.withOpacity(0.5),
//         transitionBuilder: (context, a1, a2, widget) {
//           return Transform.scale(
//             scale: a1.value,
//             child: Opacity(
//               opacity: a1.value,
//               child: AlertDialog(
//                 shape: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16.0)),
//                 title: Text('Hello!!'),
//                 content: Text('How are you?'),
//               ),
//             ),
//           );
//         },
//         transitionDuration: Duration(milliseconds: 200),
//         barrierDismissible: true,
//         barrierLabel: '',
//         context: context,
//         pageBuilder: (context, animation1, animation2) {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//   }
// }

import 'package:flutter/material.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'custom_textfeild_two.dart';

class BankDialog extends StatefulWidget {
  final TextEditingController ifsc_controller;
  final TextEditingController? bankname_controller;
  final TextEditingController? ac_number_controller;
  final TextEditingController? ac_holder_controller;

  BankDialog(
      {
     required this.ifsc_controller,
        required this.bankname_controller,
        required this.ac_number_controller,
        required this.ac_holder_controller});

  @override
  State<StatefulWidget> createState() => BankDialogState();
}

class BankDialogState extends State<BankDialog> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Bank Details",
                      style: FontStyleUtility.h12(
                        fontColor: ColorUtils.blackColor,
                        fontWeight: FWT.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: CustomTextFieldWidget_two(
                      controller: widget.ifsc_controller,
                      keyboardType: TextInputType.number,
                      labelText: 'IFSC code',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: CustomTextFieldWidget_two(
                      labelText: 'Bank Name',
                      controller: widget.bankname_controller,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: CustomTextFieldWidget_two(
                      keyboardType: TextInputType.number,
                      controller: widget.ac_number_controller,
                      labelText: 'Account Number',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 20),
                    child: CustomTextFieldWidget_two(
                      controller: widget.ac_holder_controller,
                      labelText: 'Account Holder name',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class tcDialog extends StatefulWidget {
  final TextEditingController terms_controller;


  tcDialog(
      {
        required this.terms_controller,
        });

  @override
  _tcDialogState createState() => _tcDialogState();
}

class _tcDialogState extends State<tcDialog> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Terms and Conditions",
                      style: FontStyleUtility.h12(
                        fontColor: ColorUtils.blackColor,
                        fontWeight: FWT.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: CustomTextFieldWidget_two(

                      controller: widget.terms_controller,
                      keyboardType: TextInputType.multiline,
                      labelText: 'Terms & Conditions',
                      maxLines: 4,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class noteDialog extends StatefulWidget {
  final TextEditingController note_controller;

  noteDialog(
      {
        required this.note_controller,
      });

  @override
  _noteDialogState createState() => _noteDialogState();
}

class _noteDialogState extends State<noteDialog> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Terms and Conditions",
                      style: FontStyleUtility.h12(
                        fontColor: ColorUtils.blackColor,
                        fontWeight: FWT.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: CustomTextFieldWidget_two(
                      controller: widget.note_controller,
                      keyboardType: TextInputType.number,
                      labelText: 'Notes',
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}