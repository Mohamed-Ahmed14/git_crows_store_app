import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';



class CustomTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? hintText;
  final Color? hintColor;
  final String? label;
  final Color? labelColor;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;
  final Color? fillColor;
  final TextInputType? keyboardType;


  const CustomTextForm({
    super.key,
    this.controller,
    this.validator,
    this.focusNode,
    this.hintText,
    this.label,
    this.obscureText =false,
    this.suffixIcon,
    this.enabled = true,
    this.fillColor,
    this.labelColor,
    this.hintColor,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      onTapOutside: (event) {
        focusNode?.unfocus();
      },
      cursorColor: Theme.of(context).secondaryHeaderColor,
      style: Theme.of(context).textTheme.bodyMedium,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: Theme.of(context).inputDecorationTheme.border?.copyWith(
          borderSide: BorderSide(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:AppColors.grey),
        ),
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder?.copyWith(
          borderSide: BorderSide(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        focusedBorder:
        Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
      borderSide: BorderSide(
      color: Theme.of(context).secondaryHeaderColor,
    ),
    ),
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        // disabledBorder: Theme.of(context).inputDecorationTheme.disabledBorder?.copyWith(
        //   borderSide: BorderSide(
        //     color: Theme.of(context).secondaryHeaderColor,
        //   ),
        // ),

        filled: Theme.of(context).inputDecorationTheme.filled,
        fillColor: fillColor?? Theme.of(context).inputDecorationTheme.fillColor,
        contentPadding:
        Theme.of(context).inputDecorationTheme.contentPadding,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: hintColor ?? AppColors.grey,
        ),
        hintText: hintText,
        // label: Text(
        //   label ?? '',
        //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
        //     color: labelColor ?? Theme.of(context).secondaryHeaderColor,
        //   ),
        // ),
        suffixIcon: suffixIcon,
        enabled: enabled,
      ),
    );
  }
}