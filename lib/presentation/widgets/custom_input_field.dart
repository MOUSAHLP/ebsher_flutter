
import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color_manager.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {this.fillColor,
      this.hintText,
      this.keyboardType,
      this.textStyle,
      this.suffixIcon,
      Key? key,
      this.controller,
      this.readOnly = false,
      this.textAlign = TextAlign.start,
      this.onTab,
      this.errorMessage,
      this.onChange,
      this.minLines,
      this.maxLines,
      this.contentPadding = const EdgeInsets.symmetric(horizontal: 4),
      this.height = 50,
      this.initValue,
      this.withLabel = false,
      this.inputFormatters,
      this.icon,
      this.validator})
      : super(key: key);

  final String? hintText;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final TextAlign textAlign;
  final void Function()? onTab;
  final String? errorMessage;
  final Function(String value)? onChange;
  final int? minLines;
  final int? maxLines;
  final EdgeInsets? contentPadding;
  final double? height;
  final String? initValue;
  final bool withLabel;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? icon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(28.0)),
            color: readOnly ? const Color(0xFFEEF6F6) : const Color(0xFFEEF6F6),
//            color: readOnly ? Colors.grey[400] : Color(0xFFEEF6F6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    icon,
                    color: ColorManager.primaryColor,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: initValue,
                    keyboardType: keyboardType,
                    onTap: onTab,
                    style: textStyle,
                    controller: controller,
                    readOnly: readOnly,
                    minLines: minLines,
                    maxLines: maxLines,
                    textAlign: textAlign,
                    onChanged: onChange,
                    validator: validator,
                    inputFormatters: inputFormatters,
                    decoration: InputDecoration(
                      fillColor: readOnly ? Colors.grey : const Color(0xFFEEF6F6),
                      hintText: withLabel ? null : hintText,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      label: withLabel
                          ? Text(
                              hintText!,
                              style: getBoldStyle(
                                color: ColorManager.primaryColor,
                              ),
                            )
                          : null,
                      suffixIcon: suffixIcon,
                      contentPadding: contentPadding,
                      hintStyle: getBoldStyle(
                        color: ColorManager.primaryColor,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, right: 18, left: 18),
            child: Text(
              errorMessage ?? '',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
