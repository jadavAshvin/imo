import 'package:flt_imo/Controller/LoginController/loginController.dart';
import 'package:flt_imo/Screens/Register/register.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/30sizebox.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: 200),
                // lottiIconSet(context),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "User Login",
                    style: textStyle16BoldWhite(30.0),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "Login with your email and password",
                    style: textFieldStyle20(),
                  )),
                ),
                FifteenSizeBox(),
                FifteenSizeBox(),
                loginView(context),
                ThirtynSizeBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Obx(() => loginController.processLoading.value
                      ? CustomButtonProgress(0, 0)
                      : CustomButton(txtLogin, 0, 0, () {
                          loginController.loginBtn();
                        })),
                ),
                FifteenSizeBox(),

                registerTextView(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loginView(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: textFieldStyle20(),
          keyboardType: TextInputType.emailAddress,
          controller: loginController.emailController,
          onFieldSubmitted: (r) => loginController.focus.nextFocus(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            labelText: txtEnterEmail,
            labelStyle: textFieldStyle20(),
          ),
          textInputAction: TextInputAction.next,
        ),
        FifteenSizeBox(),
        TextFormField(
          obscureText: true,
          style: textFieldStyle20(),
          controller: loginController.passwordController,
          onFieldSubmitted: (t) => loginController.focus.unfocus(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            labelText: txtEnterPassword,
            labelStyle: textFieldStyle20(),
          ),
          textInputAction: TextInputAction.done,
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
          style: textStyle16BoldWhite(20.0),
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
