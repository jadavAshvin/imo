import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/material.dart';

class CommanDropDown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final onChanged;
  final hint;
  const CommanDropDown({Key? key, required this.items, required this.onChanged, required this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: DropdownButton(
        underline: Divider(
          color: Colors.transparent,
        ),
        items: items,
        isExpanded: true,
        hint: Text(
          hint,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(color: grey),
        ),
        onChanged: onChanged,
        icon: Icon(Icons.keyboard_arrow_down),
      ),
    );
  }
}

// decoration: InputDecoration(
//             border: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1),
//                 borderRadius: BorderRadius.all(Radius.circular(5.0))),
//             labelText: labelName,
//           ),
