import 'package:flt_imo/Controller/AuthControllers/loginController.dart';
import 'package:flt_imo/Screen/Auth/register.dart';
import 'package:flt_imo/Screen/Auth/socialLogin.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/30sizebox.dart';
import 'package:flt_imo/Widgets/button.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

                registerTextView(context),
                TenSizeBox(),
                or(),
                TenSizeBox(),
                socialLoginOptions()
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
}
