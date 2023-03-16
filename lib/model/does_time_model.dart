class DoesTime{
  DoesTime({required dateTime, required doesCount}){
    this.doesCount = doesCount;
    this.dateTime = dateTime;
  }
  DateTime _dateTime = DateTime.now();
  int _doesCount = 1;

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  int get doesCount => _doesCount;

  set doesCount(int value) {
    _doesCount = value;
  }
}