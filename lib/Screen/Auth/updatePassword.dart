import 'package:flt_imo/Controller/AuthControllers/updatePasswordController.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePassword extends StatelessWidget {
  final UpdatePasswordController updateController = Get.put(UpdatePasswordController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: ListView(
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    txtUpdatePassword,
                    style: textStyle16BoldWhite(30.0),
                  )),
                ),
                FifteenSizeBox(),
                registerTextFieldView(context),
                FifteenSizeBox(),
                Obx(() => updateController.processLoading.value
                    ? CustomButtonProgress(0, 0)
                    : CustomButton(txtupdate, 0, 0, () {
                        updateController.updatePassword();
                      })),
                FifteenSizeBox(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff7687a2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget registerTextFieldView(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: textFieldStyle20(),
          keyboardType: TextInputType.text,
          obscureText: true,
          onFieldSubmitted: (v) => updateController.focus.nextFocus(),
          controller: updateController.currentPasswordController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            labelText: txtCurrentPassword,
            labelStyle: textFieldStyle20(),
          ),
          textInputAction: TextInputAction.next,
        ),
        TenSizeBox(),
        TextFormField(
          style: textFieldStyle20(),
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: updateController.newPasswordController,
          onFieldSubmitted: (v) => updateController.focus.nextFocus(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            labelText: txtnewPassword,
            labelStyle: textFieldStyle20(),
          ),
          textInputAction: TextInputAction.next,
        ),
        TenSizeBox(),
        TextFormField(
          style: textFieldStyle20(),
          keyboardType: TextInputType.visiblePassword,
          controller: updateController.confirmNewPasswordController,
          onFieldSubmitted: (v) => updateController.focus.unfocus(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            labelText: txtconfirmnewPassword,
            labelStyle: textFieldStyle20(),
          ),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
