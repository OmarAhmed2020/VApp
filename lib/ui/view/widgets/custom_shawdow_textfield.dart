import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voithy/ui/theme/app_colors.dart';

import '../../theme/app_txt_styles.dart';

class CustomShadowFormTextField extends FormField<String> {
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Color? enabledColor;
  final Color? highlightColor;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onValueChanged;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? stickyLabelStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final bool hasError;
  final bool obscureText;
  final int? maxLength;
  final bool isEditable;
  final bool worksAsPopup;
  final bool showStickyLabel;
  final bool isMandatory;
  final VoidCallback? onTextFieldClick;

  CustomShadowFormTextField(
      {this.focusNode,
      this.inputFormatters,
      this.enabledColor,
      this.highlightColor,
      this.onFieldSubmitted,
      this.onValueChanged,
      this.hintText,
      this.isMandatory = false,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.labelStyle,
      this.hintStyle,
      this.keyboardType,
      this.textInputAction,
      this.maxLines,
      this.minLines,
      this.initialValue,
      this.textEditingController,
      this.maxLength,
      this.isEditable = true,
      this.onTextFieldClick,
      this.showStickyLabel = false,
      this.worksAsPopup = false,
      this.stickyLabelStyle,
      Key? key,
      required FormFieldSetter<String> onSaved,
      required FormFieldValidator<String> validator,
      bool autoValidate = false,
      this.hasError = false,
      this.obscureText = false})
      : super(
            onSaved: onSaved,
            key: key,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<String> field) {
              final CustomShadowTextFieldFieldState state =
                  field as CustomShadowTextFieldFieldState;

              return UnmanagedRestorationScope(
                bucket: field.bucket,
                child: CustomShadowTextField(
                    focusNode: focusNode,
                    textEditingController: textEditingController,
                    key: state.localState,
                    inputFormatters: inputFormatters,
                    enabledColor: enabledColor,
                    highlightColor: highlightColor,
                    onFieldSubmitted: (value) {
                      if (onFieldSubmitted != null) {
                        onFieldSubmitted(value);
                      }
                      field.didChange(value);
                    },
                    onValueChanged: (value) {
                      if (onValueChanged != null) {
                        onValueChanged(value);
                      }
                      field.didChange(value);
                    },
                    hintText: hintText,
                    prefixIcon: prefixIcon,
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                    stickyLabelStyle: stickyLabelStyle,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    maxLines: maxLines,
                    minLines: minLines,
                    suffixIcon: suffixIcon,
                    hasError: field.hasError,
                    error: field.errorText,
                    labelText: labelText,
                    isMandatory: isMandatory,
                    worksAsPopup: worksAsPopup,
                    isEditable: isEditable,
                    maxLength: maxLength,
                    showStickyLabel: showStickyLabel,
                    onTextFieldClick: onTextFieldClick,
                    obscureText: obscureText,
                    initialValue: initialValue),
              );
            });

  @override
  FormFieldState<String> createState() => CustomShadowTextFieldFieldState();
}

class CustomShadowTextFieldFieldState extends FormFieldState<String> {
  final GlobalKey<_CustomShadowTextFieldState> localState =
      GlobalKey<_CustomShadowTextFieldState>();

  @override
  CustomShadowFormTextField get widget =>
      super.widget as CustomShadowFormTextField;

  void clear() {
    localState.currentState?.clear();
  }

  void setText(String newText) {
    localState.currentState?.setText(newText);
  }
}

class CustomShadowTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Color? enabledColor;
  final Color? highlightColor;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onValueChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? labelStyle;
  final TextStyle? stickyLabelStyle;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final String? error;
  final bool hasError;
  final bool autoFocus;
  final bool obscureText;
  final String? initialValue;
  final int? maxLength;
  final bool isEditable;
  final bool worksAsPopup;
  final VoidCallback? onTextFieldClick;
  final bool isMandatory;

  final bool showStickyLabel;
  final String? labelText;

  const CustomShadowTextField(
      {this.textEditingController,
      this.focusNode,
      this.isMandatory = false,
      this.inputFormatters,
      this.enabledColor,
      this.highlightColor,
      this.hintStyle,
      this.onFieldSubmitted,
      this.onValueChanged,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.labelStyle,
      this.keyboardType,
      this.textInputAction,
      this.maxLines,
      this.onTextFieldClick,
      this.worksAsPopup = false,
      this.stickyLabelStyle,
      this.minLines,
      this.maxLength,
      this.labelText,
      this.error,
      this.initialValue,
      this.isEditable = true,
      this.obscureText = false,
      this.hasError = false,
      this.autoFocus = false,
      this.showStickyLabel = false,
      Key? key})
      : super(key: key);

  @override
  _CustomShadowTextFieldState createState() => _CustomShadowTextFieldState();
}

class _CustomShadowTextFieldState extends State<CustomShadowTextField> {
  FocusNode? focusNode;
  TextStyle? labelStyle;

  String? value;

  bool _passwordVisible = false;
  TextEditingController textEditingController = TextEditingController();

  static double lineHeight = 1;

  @override
  CustomShadowTextField get widget => super.widget;

  // Color color = Colors.yellow;
  void clear() {
    // _resetKey = _resetKey + 1;

    value = "";
    textEditingController.clear();

    widget.onValueChanged!(null);
    setState(() {});
    if (!widget.worksAsPopup) {
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  void setText(String newText) {
    setState(() {
      textEditingController.text = newText;
      value = newText;
    });
  }

  Color getBorderColor() {
    if (focusNode != null && focusNode!.hasFocus) {
      if (widget.highlightColor != null) {
        return widget.highlightColor!;
      } else {
        return AppColors.colorECECEC;
      }
    } else {
      if (widget.hasError) {
        return Colors.red;
      }
      if (widget.error != null && widget.error!.isNotEmpty) {
        return Colors.red;
      } else {
        if (widget.enabledColor != null) {
          return widget.enabledColor!;
        } else {
          return AppColors.colorECECEC;
        }
      }
    }
  }

  @override
  void initState() {
    if (widget.focusNode == null) {
      focusNode = FocusNode();
    } else {
      focusNode = widget.focusNode;
    }

    value = widget.initialValue;

    if (widget.labelStyle != null) {
      labelStyle = widget.labelStyle;
    } else {
      labelStyle = AppTxtStyles.getAppRegularFont(
          size: 16, fontWeight: FontWeight.w400);
    }

    if (widget.textEditingController != null) {
      textEditingController = widget.textEditingController!;
    }

    if (widget.initialValue != null) {
      textEditingController.text = widget.initialValue!;
    }

    focusNode?.addListener(() {
      setState(() {});
    });

    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showStickyLabel && widget.labelText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isMandatory
              ? Text.rich(
                  TextSpan(
                    style: AppTxtStyles.getAppRegularFont(
                            size: 16, fontWeight: FontWeight.normal),
                    text: widget.labelText!, // default text style
                    children: const [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              textBaseline: TextBaseline.ideographic)),
                    ],
                  ),
                )
              : Text(
                  widget.labelText!,
                  style: widget.stickyLabelStyle ??
                      AppTxtStyles.getAppRegularFont(
                          size: 16, fontWeight: FontWeight.w400),
                ),
          const SizedBox(
            height: 10,
          ),
          getMainFieldWidget()
        ],
      );
    }
    return getMainFieldWidget();
  }

  Widget getTextButton() {
    return TextButton(
        style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: () {
          if (widget.onTextFieldClick != null) {
            return widget.onTextFieldClick!();
          }
        },
        child: IgnorePointer(ignoring: true, child: _getTextField()));
  }

  Widget getMainFieldWidget() {
    Widget field;

    if (widget.worksAsPopup) {
      field = getTextButton();
    } else {
      field = _getTextField();
    }
    Widget textField = MouseRegion(
        cursor: SystemMouseCursors.text,
        child: GestureDetector(
          onTap: () {
            if (widget.worksAsPopup == false) {
              focusNode?.requestFocus();
              // if (widget.focusNode != null &&
              //     widget.focusNode!.hasFocus == false) {
              //   widget.focusNode?.requestFocus();
              // }
            } else {
              if (widget.onTextFieldClick != null) {
                widget.onTextFieldClick!();
              }
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                decoration: getDecoration(),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Center(
                  child: Row(
                    crossAxisAlignment:
                        widget.maxLines != null && widget.maxLines! > 1
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                    children: [
                      widget.prefixIcon == null
                          ? Container()
                          : widget.prefixIcon!,
                      widget.prefixIcon == null
                          ? Container()
                          : const SizedBox(
                              width: 5,
                            ),
                      Expanded(child: field),
                      const SizedBox(
                        width: 5,
                      ),
                      widget.obscureText ? _getPasswordBtn() : Container(),
                      widget.obscureText
                          ? const SizedBox(
                              width: 5,
                            )
                          : Container(),
                      _getClearBtn(),
                      widget.suffixIcon != null
                          ? const SizedBox(
                              width: 5,
                            )
                          : Container(),
                      widget.suffixIcon ?? Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
    return IgnorePointer(
      ignoring: !widget.isEditable && !widget.worksAsPopup,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [textField, _getErrorContainer()],
      ),
    );
  }

  Widget _getTextField() {
    return TextFormField(
        focusNode: focusNode,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        controller: textEditingController,
        obscureText: isObscureText(),
        obscuringCharacter: "*",
        maxLength: widget.maxLength,
        onChanged: (value) {
          this.value = value;
          widget.onValueChanged!(value);
          setState(() {});
        },
        onFieldSubmitted: (name) {
          widget.onFieldSubmitted!(name);
        },
        //initialValue: widget.initialValue,
        autofocus: widget.autoFocus,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        //controller: textEditingController,
        style: widget.labelStyle ??
            AppTxtStyles.getAppRegularFont(
                size: 16, fontWeight: FontWeight.w400),
        cursorWidth: 2,
        showCursor: true,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            isCollapsed: true,
            isDense: true,
            contentPadding: const EdgeInsets.only(top: -5),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            counterText: '',
            counterStyle: const TextStyle(
              height: double.minPositive,
            ),
            alignLabelWithHint: true,
            disabledBorder: InputBorder.none,
            labelStyle: widget.labelStyle ??
                AppTxtStyles.getAppRegularFont(
                    size: 16, fontWeight: FontWeight.w400),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                AppTxtStyles.getAppRegularFont(
                    size: 14, fontWeight: FontWeight.w400)));
  }

  bool isObscureText() {
    if (widget.obscureText) {
      return !_passwordVisible;
    }
    return false;
  }

  BoxDecoration getDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border:
          Border.all(color: getBorderColor(), width: 1 // red as border color
              ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
            color: Colors.black12,
            blurRadius: 1.2,
            offset: Offset(0.0, 0.0)),
      ],
      color: Colors.white,
    );
  }

  Widget _getErrorContainer() {
    if (widget.error != null && widget.error!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(top: 5, start: 8),
        child: Text(
          widget.error!,
          maxLines: 2,
          style: AppTxtStyles.getAppRegularFont(
              size: 14, fontWeight: FontWeight.w400).copyWith(color: Colors.red),
        ),
      );
    }
    return Container();
  }

  Widget _getPasswordBtn() {
    if (value != null && value!.isNotEmpty) {
      return SizedBox(
        height: 25,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black26,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      );
    }
    return Container();
  }

  Widget _getClearBtn() {
    if (!widget.isEditable) {
      return Container();
    }
    String? value = this.value;
    double opacity = 0;
    bool isIgnoring = true;
    if (value != null && value.isNotEmpty) {
      opacity = 1;
      isIgnoring = false;
    }
    return IgnorePointer(
      ignoring: isIgnoring,
      child: Opacity(
        opacity: opacity,
        child: InkWell(
          onTap: () {
            clear();
          },
          child: const SizedBox(
            width: 25,
            height: 25,
            child: Center(
              child: Icon(
                Icons.close,
                size: 20,
                color: AppColors.colorECECEC,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CustomShadowTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
}
