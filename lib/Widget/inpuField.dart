import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController emailController;
  final String hint;
  final int flag;
  final int focus;
  InputField(
    this.emailController,
    this.hint,
    this.flag,
    this.focus,
  );

  @override
  Widget build(BuildContext context) {
    print("focus is $focus");
    return Container(
        height: 50.0,
        child: TextFormField(
          maxLines: 1,
          style: Theme.of(context).textTheme.subtitle2,
          keyboardType: flag == 1 ? TextInputType.emailAddress : TextInputType.number,
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(width: 1), borderRadius: BorderRadius.all(Radius.circular(5.0))),
            labelText: hint,
          ),
          onFieldSubmitted: (_) => focus == 1 ? FocusScope.of(context).nextFocus() : FocusScope.of(context).unfocus(),
          onChanged: (text) {},
        ));
  }
}
