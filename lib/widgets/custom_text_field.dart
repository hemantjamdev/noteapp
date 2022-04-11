import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  bool obSecureText;
  final FocusNode focusNode;
  final FocusNode requestFocusNode;
  final TextEditingController textEditingController;
  final Function handleOnTap;
  final bool isPasswordField;
  final String labelText;
  final String hintText;
  final String errorText;
  final bool isLastField;

  CustomTextField(
      {Key? key,
      this.obSecureText = false,
      this.isPasswordField = false,
      this.isLastField = false,
      required this.errorText,
      required this.textEditingController,
      required this.focusNode,
      required this.handleOnTap,
      required this.requestFocusNode,
      required this.hintText,
      required this.labelText})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscuringCharacter: '*',
        obscureText: widget.obSecureText,
        onFieldSubmitted: (v) {
          widget.isLastField
              ? widget.handleOnTap()
              : widget.requestFocusNode.requestFocus();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return widget.errorText;
          }
        },
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(!widget.obSecureText
                        ? Icons.vpn_key
                        : Icons.remove_red_eye_sharp),
                    onPressed: () {
                      setState(() {
                        widget.obSecureText = !widget.obSecureText;
                      });
                    },
                  )
                : null,
            labelText: widget.labelText,
            hintText: widget.hintText,
            border: const OutlineInputBorder(borderSide: BorderSide())),
        textInputAction:
            widget.isLastField ? TextInputAction.done : TextInputAction.next,
        autofocus: false,
      ),
    );
  }
}
