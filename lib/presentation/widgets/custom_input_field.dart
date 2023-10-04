import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color_manager.dart';
import '../resources/font_app.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    this.fillColor,
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
    this.validator,
    this.isPhone = false,
  }) : super(key: key);

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
  final bool isPhone;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  String? validationErrorMessage;

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = widget.controller ?? TextEditingController();
    super.initState();
  }

  void validateField(String? value) {
    setState(() {
      validationErrorMessage = widget.validator!(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(28.0)),
            color: widget.readOnly
                ? const Color(0xFFEEF6F6)
                : const Color(0xFFEEF6F6),
//            color: readOnly ? Colors.grey[400] : Color(0xFFEEF6F6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    widget.icon,
                    color: ColorManager.primaryColor,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      initialValue: widget.initValue,
                      keyboardType: widget.keyboardType,
                      onTap: widget.onTab,
                      style: widget.textStyle,
                      controller: widget.controller,
                      readOnly: widget.readOnly,
                      minLines: widget.minLines,
                      maxLines: widget.maxLines,
                      textAlign: widget.textAlign,
                      onChanged: widget.onChange,
                      validator: (value) {
                        if (widget.validator == null) return null;
                        validateField(value);
                        return widget.validator!(value);
                      },
                      inputFormatters: widget.inputFormatters,
                      decoration: InputDecoration(
                        prefix: widget.isPhone
                            ? const Text(
                                "+963 - ",
                              )
                            : null,
                        fillColor: widget.readOnly
                            ? Colors.grey
                            : const Color(0xFFEEF6F6),
                        hintText: widget.withLabel ? null : widget.hintText,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: widget.withLabel
                            ? Text(
                                widget.hintText!,
                                style: const TextStyle(
                                    color: ColorManager.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            : null,
                        suffixIcon: widget.suffixIcon,
                        errorStyle: const TextStyle(
                          fontSize: 0,
                          height: 0.1,
                        ),
                        contentPadding: widget.contentPadding,
                        hintStyle: const TextStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
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
                ),
              ],
            ),
          ),
        ),
        if (widget.errorMessage != null || validationErrorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 18, left: 18),
            child: Text(
              widget.errorMessage ?? validationErrorMessage ?? '',
              style: getBoldStyle(
                color: Colors.red,
                fontSize: FontSizeApp.s12,
              )!
                  .copyWith(height: 1),
            ),
          ),
      ],
    );
  }
}
