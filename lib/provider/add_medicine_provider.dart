import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import '../model/does_time_model.dart';
import '../model/week_day_model.dart';
import '../ui/localization/app_strings.dart';

class AddMedicineProvider extends ChangeNotifier {
  String _frequencySelection = AppStrings.selection;
  String _frequencySelectionStr = AppStrings.selection;
  String _every = AppStrings.dayOrMonth.tr;
  int _frequency = 0;
  DateTime _startDateSelected = DateTime.now();
  DateTime _endDateSelected = DateTime.now().add(const Duration(days: 1));
  String? startDateSelectedStr;
  String? endDateSelectedStr;
  bool _sound = true;
  bool _vibration = false;
  bool _refillReminder = false;
  int _currentPageIndex = 0;
  bool _isValidForm1 = false;
  bool _isValidForm2 = false;
  bool _isValidForm3 = true;
  String? _medicineName = "";
  String _everyStr = AppStrings.selection;
  bool _isDateValidEndDate = true;
  bool _isDateValidStartDate = true;
  int _daysInterval = 1;
  DoesTime? _currentDoesTime;
  int _pillsCount = 1;
  List<WeekDay> _weekDaysList = [];
  List<DoesTime> _doesTimeList = [];
  XFile? _imageFile;
  bool _isWeekDaysSelected = false;
  String _refillReminderNote = "";
  DateTime? _refillReminderDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 0);
  String? _strength;
  String? _unit = AppStrings.selection;
  String _stockPills = "";

  String get stockPills => _stockPills;

  set stockPills(String value) {
    _stockPills = value;
  }

  String? get unit => _unit;

  set unit(String? value) {
    _unit = value;
    notifyListeners();
  }

  String? get strength => _strength;

  set strength(String? value) {
    _strength = value;
    notifyListeners();
  }

  String get refillReminderNote => _refillReminderNote;

  set refillReminderNote(String value) {
    _refillReminderNote = value;
    notifyListeners();
  }

  bool get isWeekDaysSelected => _isWeekDaysSelected;

  set isWeekDaysSelected(bool value) {
    _isWeekDaysSelected = value;
    notifyListeners();
  }

  XFile? get imageFile => _imageFile;

  set imageFile(XFile? value) {
    _imageFile = value;
    notifyListeners();
  }

  int get pillsCount => _pillsCount;

  set pillsCount(int value) {
    _pillsCount = value;
    notifyListeners();
  }

  DoesTime? get currentDoesTime => _currentDoesTime;

  set currentDoesTime(DoesTime? value) {
    _currentDoesTime = value;
    notifyListeners();
  }

  List<DoesTime> get doesTimeList => _doesTimeList;

  set doesTimeList(List<DoesTime> value) {
    _doesTimeList = value;
    notifyListeners();
  }

  bool get isDateValidStartDate => _isDateValidStartDate;

  set isDateValidStartDate(bool value) {
    _isDateValidStartDate = value;
    notifyListeners();
  }

  bool get isDateValidEndDate => _isDateValidEndDate;

  set isDateValidEndDate(bool value) {
    _isDateValidEndDate = value;
    notifyListeners();
  }

  int get daysInterval => _daysInterval;

  set daysInterval(int value) {
    if (value <= 5 && value >= 1) _daysInterval = value;
    notifyListeners();
  }

  List<WeekDay> get weekDaysList => _weekDaysList;

  set weekDaysList(List<WeekDay> value) {
    _weekDaysList = value;
    notifyListeners();
  }

  String get everyStr => _everyStr;

  set everyStr(String value) {
    _everyStr = value;
    if (value == AppStrings.oneTime.tr) {
      frequency = 1;
      DateTime dateTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
      doesTimeList = [DoesTime(dateTime: dateTime, doesCount: 1)];
    } else if (value == AppStrings.twoTime.tr) {
      frequency = 2;
      DateTime dateTime1 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
      DateTime dateTime2 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 0);
      doesTimeList = [
        DoesTime(dateTime: dateTime1, doesCount: 1),
        DoesTime(dateTime: dateTime2, doesCount: 1)
      ];
      notifyListeners();
    } else if (value == AppStrings.threeTime.tr) {
      frequency = 3;
      DateTime dateTime1 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
      DateTime dateTime2 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0);
      DateTime dateTime3 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 0);
      doesTimeList = [
        DoesTime(dateTime: dateTime1, doesCount: 1),
        DoesTime(dateTime: dateTime2, doesCount: 1),
        DoesTime(dateTime: dateTime3, doesCount: 1)
      ];
      notifyListeners();
    } else if (value == AppStrings.fourTime.tr) {
      frequency = 4;
      DateTime dateTime1 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
      DateTime dateTime2 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 13, 0);
      DateTime dateTime3 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 0);
      DateTime dateTime4 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 0);
      doesTimeList = [
        DoesTime(dateTime: dateTime1, doesCount: 1),
        DoesTime(dateTime: dateTime2, doesCount: 1),
        DoesTime(dateTime: dateTime3, doesCount: 1),
        DoesTime(dateTime: dateTime4, doesCount: 1)
      ];
      notifyListeners();
    } else {
      frequency = 0;
      doesTimeList = [];
      notifyListeners();
    }
    if (frequencySelectionStr != AppStrings.selection &&
        frequencySelectionStr != AppStrings.selection.tr &&
        frequency != 0) {
      if (frequencySelectionStr == AppStrings.specificDays.tr) {
        if (isWeekDaysSelected) {
          isValidForm2 = true;
          notifyListeners();
        } else {
          isValidForm2 = false;
          notifyListeners();
        }
      } else {
        isValidForm2 = true;
        notifyListeners();
      }
    } else {
      isValidForm2 = false;
      notifyListeners();
    }
  }

  String? get medicineName => _medicineName;

  set medicineName(String? value) {
    _medicineName = value;
    notifyListeners();
    if (value != null && value.isNotEmpty) {
      isValidForm1 = true;
      notifyListeners();
    } else {
      isValidForm1 = false;
      notifyListeners();
    }
  }

  bool get isValidForm2 => _isValidForm2;

  set isValidForm2(bool value) {
    _isValidForm2 = value;
    notifyListeners();
  }

  bool get isValidForm1 => _isValidForm1;

  set isValidForm1(bool value) {
    _isValidForm1 = value;
    notifyListeners();
  }

  int get currentPageIndex => _currentPageIndex;

  set currentPageIndex(int value) {
    _currentPageIndex = value;
    notifyListeners();
  }

  bool get sound => _sound;

  set sound(bool value) {
    _sound = value;
    notifyListeners();
  }

  DateTime get startDateSelected => _startDateSelected;

  set startDateSelected(DateTime value) {
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (!value.isBefore(today) || value == today) {
      _startDateSelected = value;
      startDateSelectedStr = "${value.year} - ${value.month} - ${value.day} ";
      isDateValidStartDate = true;
      notifyListeners();
    } else {
      isDateValidStartDate = false;
    }
  }

  int get frequency => _frequency;

  set frequency(int value) {
    _frequency = value;
    notifyListeners();
  }

  String get every => _every;

  set every(String value) {
    _every = value;
    notifyListeners();
  }

  String get frequencySelection => _frequencySelection;

  set frequencySelection(String value) {
    _frequencySelection = value;
    notifyListeners();
    if (value == AppStrings.everyDay) {
      every = AppStrings.theDay;
      notifyListeners();
    } else {
      every = AppStrings.theMonth;
      notifyListeners();
    }
  }

  String get frequencySelectionStr => _frequencySelectionStr;

  set frequencySelectionStr(String value) {
    _frequencySelectionStr = value;
    notifyListeners();
    if (frequencySelectionStr != AppStrings.selection &&
        frequencySelectionStr != AppStrings.selection.tr &&
        frequency != 0) {
      if (frequencySelectionStr == AppStrings.specificDays.tr) {
        if (isWeekDaysSelected) {
          isValidForm2 = true;
          notifyListeners();
        } else {
          isValidForm2 = false;
          notifyListeners();
        }
      } else {
        isValidForm2 = true;
        notifyListeners();
      }
    } else {
      isValidForm2 = false;
      notifyListeners();
    }
    notifyListeners();
  }

  DateTime get endDateSelected => _endDateSelected;

  set endDateSelected(DateTime value) {
    if (value.isAfter(startDateSelected)) {
      _endDateSelected = value;
      endDateSelectedStr = "${value.year} - ${value.month} - ${value.day}";
      isDateValidEndDate = true;
      notifyListeners();
    } else {
      isDateValidEndDate = false;
    }
  }

  bool get vibration => _vibration;

  set vibration(bool value) {
    _vibration = value;
    notifyListeners();
  }

  bool get refillReminder => _refillReminder;

  set refillReminder(bool value) {
    _refillReminder = value;
    notifyListeners();
  }

  void disposeData() {
    frequency = 0;
    frequencySelection = AppStrings.selection;
    frequencySelectionStr = AppStrings.selection;
    every = AppStrings.dayOrMonth.tr;
    startDateSelected = DateTime.now();
    endDateSelected = DateTime.now().add(const Duration(days: 1));
    currentPageIndex = 0;
    sound = true;
    vibration = false;
    refillReminder = false;
    every = AppStrings.dayOrMonth.tr;
    everyStr = AppStrings.selection;
    isDateValidEndDate = true;
    isDateValidStartDate = true;
    daysInterval = 1;
    isValidForm1 = false;
    isValidForm2 = false;
    isValidForm3 = true;
    imageFile = null;
    isWeekDaysSelected = false;
    refillReminderNote = "";
    refillReminderDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 0);
    medicineName = null;
    strength = null;
    unit = AppStrings.ml.tr;
    startDateSelectedStr = AppStrings.selection;
    endDateSelectedStr = AppStrings.selection;
    currentDoesTime = null;
    pillsCount = 1;
    weekDaysList = [];
    doesTimeList = [];
    stockPills = "";
  }

  bool get isValidForm3 => _isValidForm3;

  set isValidForm3(bool value) {
    _isValidForm3 = value;
    notifyListeners();
  }

  List<WeekDay> getWeekDaysList() {
    List<WeekDay> daysList = [];
    List<String> days = [
      AppStrings.friday.tr,
      AppStrings.saturday.tr,
      AppStrings.sunday.tr,
      AppStrings.monday.tr,
      AppStrings.tuesday.tr,
      AppStrings.wednesday.tr,
      AppStrings.thursday.tr
    ];
    for (int i = 0; i < 7; i++) {
      WeekDay day = WeekDay();
      day.selected = false;
      day.dayName = days[i];
      daysList.add(day);
    }
    return daysList;
  }

  void updateDayBySelection(int index, WeekDay day) {
    List<WeekDay> daysList = weekDaysList;
    daysList[index] = day;
    weekDaysList = daysList;
    for (int i = 0; i < weekDaysList.length; i++) {
      WeekDay day = weekDaysList[i];
      if (day.selected == true) {
        isWeekDaysSelected = true;
        notifyListeners();
        break;
      } else {
        isWeekDaysSelected = false;
        notifyListeners();
      }
    }
    if (frequencySelectionStr != AppStrings.selection &&
        frequencySelectionStr != AppStrings.selection.tr &&
        frequency != 0) {
      if (frequencySelectionStr == AppStrings.specificDays.tr) {
        if (isWeekDaysSelected) {
          isValidForm2 = true;
          notifyListeners();
        } else {
          isValidForm2 = false;
          notifyListeners();
        }
      } else {
        isValidForm2 = true;
        notifyListeners();
      }
    } else {
      isValidForm2 = false;
      notifyListeners();
    }
  }

  void updateDoesTimeList(int doesTimeIndex) {
    currentDoesTime = this.doesTimeList[doesTimeIndex];
    List<DoesTime> doesTimeList = this.doesTimeList;
    doesTimeList[doesTimeIndex] = currentDoesTime!;
    this.doesTimeList = doesTimeList;
    notifyListeners();
  }

  DateTime? get refillReminderDateTime => _refillReminderDateTime;

  set refillReminderDateTime(DateTime? value) {
    _refillReminderDateTime = value;
    notifyListeners();
  }
}
