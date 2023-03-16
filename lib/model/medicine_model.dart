enum MedicineAction {
  reScheduled,
  taken,
  skipped,
  dueDose,
  upcoming
}

class Medicine {
  Medicine(
      {required String medicineName,
      required MedicineAction? action,
      required int amount,
      required String unit}) {
    this.medicineName = medicineName;
    this.action = action;
    this.amount = amount;
    this.unit = unit;
  }

  String? _medicineName;
  MedicineAction? _action;
  String _unit = "mg";
  int _amount = 1;

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }

  String? get medicineName => _medicineName;

  set medicineName(String? value) {
    _medicineName = value;
  }

  MedicineAction? get action => _action;

  set action(MedicineAction? value) {
    _action = value;
  }

  String get unit => _unit;

  set unit(String value) {
    _unit = value;
  }
}
