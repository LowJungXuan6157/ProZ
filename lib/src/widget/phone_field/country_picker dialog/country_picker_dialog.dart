import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../phone_field_index.dart';

class ProZCountryPickerDialog extends GetView<ProZPhoneFieldController> {
  final Function(Country?) onCountryChanged;

  const ProZCountryPickerDialog({
    Key? key,
    required this.onCountryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 40.0),
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 30,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    labelText: controller.state.searchTextLabel.value,
                  ),
                  onChanged: (value) {
                    controller.filterCountries(value);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.state.filteredCountries.length,
                  itemBuilder: (ctx, index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: Image.asset(
                          'assets/flags/${controller.state.filteredCountries[index].code.toLowerCase()}.png',
                          width: 32,
                        ),
                        title: Text(
                          controller.state.filteredCountries[index].name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        trailing: Text(
                          '+${controller.state.filteredCountries[index].dialCode}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        onTap: () async {
                          onCountryChanged(controller.state.filteredCountries[index]);
                          Navigator.of(context).pop();
                        },
                      ),
                      const Divider(thickness: 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
