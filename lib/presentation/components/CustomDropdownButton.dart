// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdownButton extends StatelessWidget {
  final String text;
  final double iconSize;
  final selectedValue;
  final onChanged;
  final items;
  final bool enabled;

  const CustomDropdownButton(
      {Key? key,
      required this.text,
      required this.iconSize,
      required this.selectedValue,
      required this.onChanged,
      required this.items,
      required this.enabled})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 65),
        height: MediaQuery.of(context).size.height / 20,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  text,
                  // style: appTheme.themeData.primaryTextTheme.headline6!
                  //     .apply(fontSizeDelta: -1.5),
                ),
                icon: const Flexible(
                    child: Icon(Icons.arrow_drop_down,
                        color: Color.fromRGBO(127, 127, 127, 1.0))),
                iconSize: iconSize,
                value: selectedValue,
                onChanged: enabled ? onChanged : null,
                // style: appTheme.themeData.primaryTextTheme.headline6,
                items: items),
          ),
        ),
      ),
    );
  }
}
