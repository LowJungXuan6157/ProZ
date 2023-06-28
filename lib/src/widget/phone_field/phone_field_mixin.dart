import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'phone_field_index.dart';

mixin PhoneFieldMixin on State<ProZPhoneField> {
  final ProZPhoneFieldState state = ProZPhoneFieldState();

  void initialization() {
    super.initState();
    handleHideCancelIcon();
    widget.controller!.addListener(handleHideCancelIcon);
    (widget.focusNode!).addListener(handleHideOuterLabel);
    state.countryList = widget.countries == null ? countries : countries.where((country) => widget.countries!.contains(country.code)).toList();
    state.filteredCountries = state.countryList;
    state.number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && state.number.startsWith('+')) {
      state.number = state.number.value.substring(1);
      // parse initial value
      state.selectedCountry = countries.firstWhere((country) => state.number.value.startsWith(country.fullCountryCode), orElse: () => state.countryList.first);

      // remove country code from the initial number value
      state.number = state.number.value.replaceFirst(RegExp("^${state.selectedCountry.value?.fullCountryCode}"), "");
    } else {
      state.selectedCountry = state.countryList.firstWhere((item) => item.code == (widget.initialCountryCode ?? 'MY'), orElse: () => state.countryList.first);

      // remove country code from the initial number value
      if (state.number.value.startsWith('+')) {
        state.number = state.number.value.replaceFirst(RegExp("^\\+${state.selectedCountry.value?.fullCountryCode}"), "");
      } else {
        state.number = state.number.value.replaceFirst(RegExp("^${state.selectedCountry.value?.fullCountryCode}"), "");
      }
    }
  }

  void handleHideOuterLabel() {
    state.isShowOuterLabel = !state.isShowOuterLabel.value;
  }

  Future<void> changeCountry() async {
    state.filteredCountries = state.countryList;
    Get.put(ProZPhoneFieldController(
      searchTextLabel: widget.searchTextLabel,
      countryList: state.countryList,
      filteredCountries: state.filteredCountries,
    ));
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => ProZCountryPickerDialog(
          onCountryChanged: (Country? country) {
            state.selectedCountry = country!;
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Widget? buildCloseIcon() {
    if (state.showCancelIconInState.value) {
      return GestureDetector(
        onTap: () {
          widget.controller?.clear();
          widget.focusNode?.requestFocus();
        },
        child: Container(
          color: Colors.transparent,
          child: const Icon(Icons.cancel),
        ),
      );
    } else {
      return widget.decoration.suffixIcon;
    }
  }

  void handleHideCancelIcon() {
    if (widget.controller!.text.isEmpty && widget.showCancelIcon) {
      state.showCancelIconInState = false;
    } else {
      if (!state.showCancelIconInState.value && widget.showCancelIcon) {
        state.showCancelIconInState = true;
      }
    }
  }
}
