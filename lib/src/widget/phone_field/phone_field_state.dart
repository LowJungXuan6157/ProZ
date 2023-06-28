import 'package:get/get.dart';

import 'phone_field_index.dart';

class ProZPhoneFieldState {
  ProZPhoneFieldState() {
    ///Initialize variables
  }

  /// [ProZCountryPickerDialog] && [ProZPhoneField] country list
  final _countryList = <Country>[].obs;

  RxList<Country> get countryList => _countryList;

  set countryList(value) => _countryList.value = value;

  /// [ProZCountryPickerDialog] && [ProZPhoneField] country selected
  final _selectedCountry = Rxn<Country>();

  Rxn<Country> get selectedCountry => _selectedCountry;

  set selectedCountry(value) => _selectedCountry.value = value;

  /// [ProZCountryPickerDialog] country changed
  final Rxn<Country> onCountryChanged = Rxn<Country>();

  /// [ProZCountryPickerDialog] search text
  final RxString searchTextLabel = "".obs;

  /// [ProZCountryPickerDialog] country filtered
  final _filteredCountries = <Country>[].obs;

  RxList<Country> get filteredCountries => _filteredCountries;

  set filteredCountries(value) => _filteredCountries.value = value;

  ///outlined label at [ProZPhoneField]
  final _isShowOuterLabel = false.obs;

  RxBool get isShowOuterLabel => _isShowOuterLabel;

  set isShowOuterLabel(value) => _isShowOuterLabel.value = value;

  ///initialValue of country at [ProZPhoneField] e.g.(+60/MY)
  final _number = "".obs;

  RxString get number => _number;

  set number(value) => _number.value = value;

  ///cancel icon at [ProZPhoneField]
  final _showCancelIconInState = false.obs;

  RxBool get showCancelIconInState => _showCancelIconInState;

  set showCancelIconInState(value) => _showCancelIconInState.value = value;
}
