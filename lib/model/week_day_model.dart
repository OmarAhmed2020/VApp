class WeekDay{
  bool _selected = false;
  String _dayName = "";

  bool get selected => _selected;

  set selected(bool value) {
    _selected = value;
  }

  String get dayName => _dayName;

  set dayName(String value) {
    _dayName = value;
  }
}