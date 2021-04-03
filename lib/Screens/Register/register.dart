import 'package:flt_imo/Controller/RegisterController/registerController.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Register extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
  final flag;
  final screen;

  Register({Key key, this.flag, this.screen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: [
            Align(alignment: Alignment.centerLeft, child: setbackButton(context)),
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                flag == 1 ? txtEditProfile : txtUserRegister,
                style: textStyle16BoldWhite(30.0),
              )),
            ),
            if (flag == 0)
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  txtUserRegisterWith,
                  style: textFieldStyle20(),
                )),
              ),
            FifteenSizeBox(),
            FifteenSizeBox(),
            registerTextFieldView(context),
            FifteenSizeBox(),
            if (flag == 0) setTermsConditioneView(context),
            if (flag == 0) FifteenSizeBox(),
            Obx(() => registerController.processLoading.value
                ? CustomButtonProgress(0, 0)
                : CustomButton(flag == 1 ? txtUpdateProfile : txtRegister, 0, 0, () {
                    registerController.registerBtn(flag);
                  })),
            FifteenSizeBox(),
            if (flag == 0) setAlredyLoginView(context),
          ],
        ),
      ),
    );
  }

  Widget registerTextFieldView(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            onEditingComplete: () => registerController.focus.nextFocus(),
            controller: registerController.fullNameController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtFullName,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        if (flag == 0) TenSizeBox(),
        if (flag == 0)
          SizedBox(
            height: 5,
          ),
        if (flag == 0)
          Container(
            child: TextFormField(
              style: textFieldStyle20(),
              keyboardType: TextInputType.emailAddress,
              controller: registerController.emailController,
              onEditingComplete: () => registerController.focus.nextFocus(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                labelText: txtEmailAddress,
                labelStyle: textFieldStyle20(),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        TenSizeBox(),
        Row(
          children: [
            bottomSheetOpen(context),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(left: 0, top: 6),
                child: TextFormField(
                  style: textFieldStyle20(),
                  keyboardType: TextInputType.number,
                  controller: registerController.mobileNumberController,
                  onEditingComplete: () => registerController.focus.nextFocus(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    labelText: txtMobileNumber,
                    labelStyle: textFieldStyle20(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
          ],
        ),
        if (flag == 0) TenSizeBox(),
        if (flag == 0)
          TextFormField(
            obscureText: true,
            style: textFieldStyle20(),
            keyboardType: TextInputType.emailAddress,
            controller: registerController.passwordController,
            onEditingComplete: () => registerController.focus.nextFocus(),
            decoration: InputDecoration(
              labelText: txtCreatePassword,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
      ],
    );
  }

  Widget setTermsConditioneView(BuildContext context) {
    return Obx(
      () => Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: (registerController.isChecked.value) ? Colors.black : Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    )),
                width: 22.0,
                height: 22.0,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.transparent,
                  ),
                  child: Obx(() => Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: registerController.isChecked.value,
                        tristate: false,
                        onChanged: (bool isChecked) {
                          registerController.isChecked.value = isChecked;
                          registerController.update();
                        },
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: txtIAgreeToIMO + " ", style: textStyleBlack(18)),
                      TextSpan(text: txtTermsOfUse, style: TextStyle(decoration: TextDecoration.underline, fontSize: 19, color: Colors.blue)),
                    ],
                  ),
                ) /*Text(
                  txtIAgreeToIMO,
                  style: textStylePrimary(18),
                )*/
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget registerTextView(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Text(
          txtCreateAccount,
          style: textStyleBlack(16.0),
        )),
      ),
    );
  }

  Widget lottiIconSet(BuildContext context) {
    return Container(
      height: 155.0,
      width: 155.0,
      child: Lottie.asset(
        Images.REGISTER_JSON,
        repeat: false,
      ),
    );
  }

  Widget setbackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.only(left: 0, top: 10),
        alignment: Alignment.topLeft,
        height: 50,
        width: 50,
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Widget bottomSheetOpen(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 7),
      width: Get.width / 9,
      child: CountryCodePicker(
        hideMainText: true,

        onChanged: (val) {
          registerController.conCode = val.toString();
          print(registerController.conCode);
        },
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: 'IN',
        favorite: ['+1', 'US'],
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
    );
  }

  Widget setAlredyLoginView(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: txtAlreadyRegister + " ", style: textStyleBlack(20)),
                  TextSpan(text: txtLogin, style: TextStyle(decoration: TextDecoration.underline, fontSize: 21, color: Colors.blue)),
                ],
              ),
            ),
          )),
    );
  }
}
