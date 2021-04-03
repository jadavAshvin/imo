import 'package:flt_imo/Controller/LoginController/loginController.dart';
import 'package:flt_imo/Screens/Home/home.dart';
import 'package:flt_imo/Screens/Register/register.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/decoration.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Login11 extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            SizedBox(height: 100),
            lottiIconSet(context),
            FifteenSizeBox(),
            FifteenSizeBox(),
            loginView(context),
            FifteenSizeBox(),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomButton(txtLogin, 0, 0, () {
                Get.to(HomeScreen());
              }),
            ),
            FifteenSizeBox(),
            registerTextView(context)
          ],
        ),
      ),
    );
  }

  Widget loginView(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 3.0, bottom: 3.0),
          decoration: boxDecoration(),
          child: TextFormField(
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.emailAddress,
            onEditingComplete: () => loginController.focus.nextFocus(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: txtEnterEmail,
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        FifteenSizeBox(),
        Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 3.0, bottom: 3.0),
          decoration: boxDecoration(),
          child: TextFormField(
            obscureText: true,
            style: TextStyle(fontSize: 18),
            onEditingComplete: () => loginController.focus.unfocus(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: txtEnterPassword,
            ),
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }

  Widget registerTextView(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(Register());
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Text(
          txtCreateAccount,
          style: textStyle16Bold(20.0),
        )),
      ),
    );
  }

  Widget lottiIconSet(BuildContext context) {
    return Container(
      height: 155.0,
      width: 155.0,
      child: Lottie.asset(
        Images.LOGIN_JSON,
        repeat: false,
      ),
    );
  }
}
