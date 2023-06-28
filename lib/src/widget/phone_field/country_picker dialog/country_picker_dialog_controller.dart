import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../pro_z.dart';

///Binding [ProZPhoneFieldBinding]
class ProZPhoneFieldBinding extends Bindings {
  final String searchTextLabel;
  final List<Country> countryList, filteredCountries;
  final Country selectedCountry;

  ProZPhoneFieldBinding({
    required this.searchTextLabel,
    required this.countryList,
    required this.selectedCountry,
    required this.filteredCountries,
  });

  @override
  void dependencies() {
    Get.lazyPut(() => ProZPhoneFieldController(
          searchTextLabel: searchTextLabel,
          countryList: countryList,
          filteredCountries: filteredCountries,
        ));
  }
}

class ProZPhoneFieldController extends GetxController {
  final ProZPhoneFieldState state = ProZPhoneFieldState();
  TextEditingController textController = TextEditingController();

  ProZPhoneFieldController({
    required String searchTextLabel,
    required List<Country> countryList,
    required List<Country> filteredCountries,
  }) {
    state.searchTextLabel.value = searchTextLabel;
    state.countryList.value = countryList;
    state.filteredCountries.value = filteredCountries;
  }

  List<Country> filterCountries(String value) {
    return state.filteredCountries = (value.isNotEmpty && double.tryParse(value) != null)
        ? state.countryList
            .where(
              (country) => country.dialCode.contains(value),
            )
            .toList()
        : state.countryList.where((country) => country.name.toLowerCase().contains(value.toLowerCase())).toList();
  }
}
