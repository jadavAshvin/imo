import 'package:flt_imo/Controller/AuthControllers/registerController.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Register extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

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
                txtUserRegister,
                style: textStyle16BoldWhite(30.0),
              )),
            ),
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
            setTermsConditioneView(context),
            FifteenSizeBox(),
            Obx(() => registerController.processLoading.value
                ? CustomButtonProgress(0, 0)
                : CustomButton(txtRegister, 0, 0, () {
                    registerController.registerBtn();
                  })),
            FifteenSizeBox(),
            setAlredyLoginView(context),
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
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
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
            // bottomSheetOpen(context),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(left: 0, top: 6),
                child: TextFormField(
                  style: textFieldStyle20(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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
        TenSizeBox(),
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
        5.heightBox,
        "Password must have one uppercase, one special character & 8 digits".text.color(Colors.red).make()
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
                        onChanged: (bool? isChecked) {
                          registerController.isChecked.value = isChecked!;
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

        showCountryOnly: true,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
        initialSelection: 'US',
        favorite: ['+1', 'US'],
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
