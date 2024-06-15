import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


import '../../core/constants/app_colors.dart';
import 'my_text_widget.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  final List<dynamic>? items;
  String? selectedValue;
  final ValueChanged<dynamic>? onChanged;
  String hint;
  Color? bgColor;
  Color? hintTextColor;
  final String? label;
  final bool haveLabel;
  final double radius;

  CustomDropDown(
      {super.key,
      this.hint = '',
      required this.items,
      this.selectedValue,
      required this.onChanged,
      this.bgColor,
      this.hintTextColor,
      this.label,
      this.haveLabel = true,
      this.radius = 5});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        haveLabel
            ? MyText(
                paddingBottom: 7,
                text: label ?? "lebel Text Here",
                size: 12,
                weight: FontWeight.w400,
                color: kBlackColor1,
              )
            : SizedBox(),
        DropdownButton2(


          underline: InputDecorator(decoration: InputDecoration()),
          isDense: true,
          isExpanded: true,
          buttonStyleData: ButtonStyleData(
              height: 47.12,
              padding: EdgeInsets.only(left: 0, right: 8),
              decoration: BoxDecoration(

                  // Border Decoration

                  border: Border.all(
                    color: kGreyColor3,
                  ),
                  color: bgColor ?? kWhiteColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(radius))),
          dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
            color: kGreyColor2,
            borderRadius: BorderRadius.circular(5),
          )),
          menuItemStyleData: MenuItemStyleData(
            height: 47,
          ),
          items: items!
              .map(
                (item) => DropdownMenuItem<dynamic>(
                  value: item,
                  child: MyText(
                    text: item,
                    color: kBlackColor1,
                    size: 13.44,
                  ),
                ),
              )
              .toList(),
          hint: MyText(
            text: hint,
            color: hintTextColor,
            size: 12,
            weight: FontWeight.w500,
          ),
          value: selectedValue,
          onChanged: onChanged,
          iconStyleData: IconStyleData(
              icon: Icon(
            Icons.arrow_drop_down,
            color: kBlackColor50Percent,
          )),
        ),
      ],
    );
  }
}
