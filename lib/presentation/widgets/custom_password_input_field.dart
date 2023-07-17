import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

class CustomPasswordInputField extends StatefulWidget {
  const CustomPasswordInputField({
    this.fillColor,
    this.hintText,
    this.textStyle,
    Key? key,
    this.controller,
    this.errorMessage,
    this.onChange,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 4),
    this.height = 50,
    this.withLabel = false,
    this.icon,
    this.validator,
  }) : super(key: key);

  final String? hintText;
  final Color? fillColor;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final String? errorMessage;
  final Function(String value)? onChange;
  final EdgeInsets? contentPadding;
  final double? height;
  final bool withLabel;
  final IconData? icon;
  final String? Function(String?)? validator;

  @override
  State<CustomPasswordInputField> createState() =>
      _CustomPasswordInputFieldState();
}

class _CustomPasswordInputFieldState extends State<CustomPasswordInputField> {
  bool obscure = true;
  String? validationErrorMessage;

  void toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(28.0)),
            color: Color(0xFFEEF6F6),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 8, start: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    widget.icon,
                    color: ColorManager.primaryColor,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    style: widget.textStyle,
                    controller: widget.controller,
                    onChanged: widget.onChange,
                    obscureText: obscure,
                    validator: (value) {
                      if (widget.validator == null) return null;
                      validateField(value);
                      return widget.validator!(value);
                    },
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFEEF6F6),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: widget.withLabel ? null : widget.hintText,
                      label: widget.withLabel
                          ? Text(
                              widget.hintText!,
                              style: TextStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 0,
                        height: 0.1,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => toggleObscure(),
                        child: Icon(
                          Icons.remove_red_eye,
                          color:
                              obscure ? Colors.grey : ColorManager.primaryColor,
                        ),
                      ),
                      contentPadding: widget.contentPadding,
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
        if (widget.errorMessage != null || validationErrorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, right: 18, left: 18),
            child: Text(
              widget.errorMessage ?? validationErrorMessage ?? '',
              style: getBoldStyle(
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
