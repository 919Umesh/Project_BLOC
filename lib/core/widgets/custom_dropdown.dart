import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class CustomDropDown {
  static void show({
    required BuildContext context,
    required List<SelectedListItem<String>> items,
    required Function(List<String>) onSelected,
  }) {
    DropDownState<String>(
      dropDown: DropDown<String>(
        data: items,
        onSelected: (selectedItems) {
          List<String> list = selectedItems.map((item) => item.data).toList();
          onSelected(list);
        },
      ),
    ).showModal(context);
  }
}
