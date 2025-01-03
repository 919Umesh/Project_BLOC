import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_bloc/core/core.dart';


import '../../app/app.dart';

class CustomTextFromField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText, hintText, optionalParam;
  final void Function(String text)? onChanged;
  final void Function(String text)? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final bool readOnly;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final bool autofocus;
  final bool isRequired;
  final bool obscureText;
  final String obscuringCharacter;
  final int maxLines;
  final int? maxLenght;
  final Widget? suffix;
  final Color? fillColor;

  const CustomTextFromField({
    super.key,
    this.controller,
    this.labelText = "",
    this.hintText = "",
    this.optionalParam = "",
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.maxLenght,
    this.suffix,
    this.obscureText = false,
    this.obscuringCharacter = "X",
    this.fillColor,
    this.onSaved,
  });

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  late String? errorText = "";
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText.isNotEmpty)
          Row(
            children: [
              Text(widget.labelText, style: kTitleTextBold),
              if (widget.optionalParam.isNotEmpty)
                Text(
                  "  ${widget.optionalParam}",
                  style: const TextStyle(color: kPrimaryColor, fontSize: 11.0),
                ),
              if (widget.isRequired)
                const Text(' *', style: TextStyle(color: Colors.red)),
              if (showError)
                Text(
                  " $errorText",
                  style: const TextStyle(color: Colors.red, fontSize: 10.0),
                ),
            ],
          ).paddingSymmetric(3.0),
        2.pHeight,
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            setState(() {
              errorText = widget.validator?.call(value);
              showError = errorText != null;
            });
            debugPrint("${widget.labelText} ERROR TEXT => $errorText");
            return errorText;
          },
          style: kHintText.copyWith(color: Colors.black, fontSize: 16.0),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          maxLines: widget.maxLines,
          maxLength: widget.maxLenght,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          onFieldSubmitted: widget.onFieldSubmitted,
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign,
          decoration: TextFieldDecoration.decoration(
            hintText: widget.hintText,
            suffix: widget.suffix,
            fillColor: widget.fillColor,
          ),
        ),
      ],
    );
  }
}
