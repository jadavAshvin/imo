import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final onChanged;

  CustomSearchBar({this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: textFieldStyle20(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: "Search.....",
        ),
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
