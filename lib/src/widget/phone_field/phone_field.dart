library com.veecotech.itsu;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'phone_field_index.dart';

class ProZPhoneField extends StatefulWidget {
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<Country>? onCountryChanged;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled": it ignores taps, the [TextFormField]'s
  final bool enabled;
  final bool showCursor;

  ///Prevent country from being changed: it won't call [ProZCountryPickerDialog]
  final bool isCountrySelectionEnabled;

  ///initialCountryCode: '+225', // Côte d'Ivoire
  final String? initialValue;

  /// 2 letter ISO Code or country dial code.
  ///
  /// ```dart
  /// initialCountryCode: 'IN', // India
  /// ```
  final String? initialCountryCode;

  /// List of 2 Letter ISO Codes of countries to show. Defaults to showing the inbuilt list of all countries.
  final List<String>? countries;
  final InputDecoration decoration;
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool disableLengthCheck;
  final bool showDropdownIcon;
  final BoxDecoration dropdownDecoration;
  final TextStyle? dropdownTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String searchTextLabel;

  /// Position of an icon [leading, trailing]
  final IconPosition dropdownIconPosition;
  final Icon dropdownIcon;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  final bool showCountryFlag;
  final EdgeInsetsGeometry flagsButtonPadding;
  final TextInputAction? textInputAction;
  final EdgeInsets flagsButtonMargin;
  final FormFieldValidator<String>? validator;

  ///providing hint before user type anything in the text box
  final String? hintText;

  ///showing label text outer of the the [TextFormField]'s
  final bool showLabelTextOuter;

  /// Icon [Icons.cancel] at right of text field
  /// When text is not empty then icon will be shown
  /// And if text is empty then icon will be hide
  final bool showCancelIcon;

  const ProZPhoneField({
    Key? key,
    this.showCancelIcon = false,
    this.showCursor = true,
    this.hintText,
    this.showLabelTextOuter = false,
    this.initialCountryCode,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.number,
    required this.controller,
    required this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.isCountrySelectionEnabled = true,
    this.searchTextLabel = 'Search country',
    this.dropdownIconPosition = IconPosition.leading,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.disableLengthCheck = false,
    this.flagsButtonPadding = EdgeInsets.zero,
    this.flagsButtonMargin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  PhoneFieldState createState() => PhoneFieldState();
}

class PhoneFieldState extends State<ProZPhoneField> with PhoneFieldMixin {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.showLabelTextOuter
              ? Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Visibility(
                    visible: state.isShowOuterLabel.value || widget.controller!.text.isNotEmpty,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      opacity: state.isShowOuterLabel.value || widget.controller!.text.isNotEmpty ? 1 : 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(
                          widget.decoration.hintText ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          TextFormField(
            initialValue: (widget.controller == null) ? state.number.value : null,
            readOnly: widget.readOnly,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            onTap: widget.onTap,
            showCursor: widget.showCursor,
            controller: widget.controller,
            focusNode: widget.focusNode,
            cursorRadius: Radius.zero,
            cursorWidth: 2.0,
            onFieldSubmitted: widget.onSubmitted,
            decoration: widget.decoration.copyWith(
              prefixIcon: _buildFlagsButton(),
              suffixIcon: widget.showCancelIcon ? buildCloseIcon() : null,
              hintText: widget.hintText,
              counterText: !widget.isCountrySelectionEnabled ? '' : null,
            ),
            style: widget.style,
            onSaved: (value) {
              widget.onSaved?.call(
                PhoneNumber(
                  countryISOCode: state.selectedCountry.value!.code,
                  countryCode: '+${state.selectedCountry.value!.dialCode}${state.selectedCountry.value!.regionCode}',
                  number: value!,
                ),
              );
            },
            onChanged: (value) async {
              final phoneNumber = PhoneNumber(
                countryISOCode: state.selectedCountry.value!.code,
                countryCode: '+${state.selectedCountry.value!.fullCountryCode}',
                number: value,
              );

              widget.onChanged?.call(phoneNumber);
            },
            validator: widget.validator,
            maxLength: widget.disableLengthCheck ? null : state.selectedCountry.value!.maxLength,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            textInputAction: widget.textInputAction,
            autovalidateMode: widget.autovalidateMode,
          ),
        ],
      ),
    );
  }

  Container _buildFlagsButton() {
    return Container(
      margin: widget.flagsButtonMargin,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: InkWell(
          borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
          onTap: widget.isCountrySelectionEnabled ? changeCountry : null,
          child: Padding(
            padding: widget.flagsButtonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.isCountrySelectionEnabled && widget.showDropdownIcon && widget.dropdownIconPosition == IconPosition.leading) ...[
                  widget.dropdownIcon,
                  const SizedBox(width: 4),
                ],
                if (widget.showCountryFlag) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/flags/${state.selectedCountry.value!.code.toLowerCase()}.png',
                        ),
                        radius: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                FittedBox(
                  child: Text(
                    '+${state.selectedCountry.value!.dialCode}',
                    style: widget.dropdownTextStyle,
                  ),
                ),
                if (widget.isCountrySelectionEnabled && widget.showDropdownIcon && widget.dropdownIconPosition == IconPosition.trailing) ...[
                  const SizedBox(width: 4),
                  widget.dropdownIcon,
                ],
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}
