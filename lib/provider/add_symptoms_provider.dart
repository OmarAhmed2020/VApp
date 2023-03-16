
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../ui/localization/app_strings.dart';

class AddSymptomsProvider extends ChangeNotifier {
  String _typeSelection = AppStrings.selection;
  DateTime _startDateSelected = DateTime.now();
  DateTime startTimeSelected = DateTime.now();
  String? startDateSelectedStr;
  String? startTimeSelectedStr;

  String get typeSelection => _typeSelection;

  set typeSelection(String value) {
    _typeSelection = value;
  }

  DateTime get startDateSelected => _startDateSelected;

  set startDateSelected(DateTime value) {
    _startDateSelected = value;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startDateSelectedStr = AppStrings.selection;
    startTimeSelectedStr = AppStrings.selection;
  }
}