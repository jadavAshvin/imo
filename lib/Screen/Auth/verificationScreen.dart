import 'package:flt_imo/Controller/AuthControllers/verificationController.dart';
import 'package:flt_imo/Screen/Auth/login.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/30sizebox.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatelessWidget {
  final email;
  final userId;

  VerificationScreen({Key key, this.email, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final VerificationController verifyController = Get.put(VerificationController());
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
                    "Verify OTP",
                    style: textStyle16BoldWhite(30.0),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "OTP has been sent to your registered email id",
                    style: textFieldStyle20(),
                  )),
                ),
                FifteenSizeBox(),
                FifteenSizeBox(),
                loginView(context, verifyController),
                ThirtynSizeBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Obx(() => verifyController.processLoading.value
                      ? CustomButtonProgress(0, 0)
                      : CustomButton("Verify", 0, 0, () {
                          verifyController.userId = userId;
                          verifyController.emailId = email;
                          verifyController.verifyBtn();
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

  Widget loginView(BuildContext context, verifyController) {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      textInputType: TextInputType.number,
      controller: verifyController.pinController,
      pinTheme: PinTheme(
        activeColor: Get.theme.primaryColor,
        inactiveFillColor: white,
        inactiveColor: grey,
        selectedFillColor: Get.theme.primaryColor,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 55,
        fieldWidth: Get.width / 9,
        activeFillColor: white,
      ),
      onCompleted: (v) {},
      onChanged: (String value) {
        verifyController.pin = value;
      },
    );

    // return TextFormField(
    //   style: textFieldStyle20(),
    //   keyboardType: TextInputType.emailAddress,
    //   controller: verifyController.pinController,
    //   onEditingComplete: () => verifyController.focus.nextFocus(),
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.all(0.0),
    //     labelText: txtEnterOTP,
    //     labelStyle: textFieldStyle20(),
    //   ),
    //   textInputAction: TextInputAction.next,
    // );
  }

  Widget registerTextView(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.offAll(Login());
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Text(
          txtLogin,
          style: textStyle16BoldWhite(20.0),
        )),
      ),
    );
  }

  // Widget lottiIconSet(BuildContext context) {
  //   return Container(
  //     height: 155.0,
  //     width: 155.0,
  //     child: Lottie.asset(
  //       Images.LOGIN_JSON,
  //       repeat: false,
  //     ),
  //   );
  // }
}
