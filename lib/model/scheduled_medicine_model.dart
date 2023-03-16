import 'medicine_model.dart';

class ScheduledMedicine
{
  
  DateTime? _dateTime;
  List<Medicine>? _medicineList;

  DateTime? get dateTime => _dateTime;

  set dateTime(DateTime? value) {
    _dateTime = value;
  }

  List<Medicine>? get medicineList => _medicineList;

  set medicineList(List<Medicine>? value) {
    _medicineList = value;
  }
}