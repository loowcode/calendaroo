class Date extends DateTime {

  Date(int year, [int month = 1, int day = 1]) : super(year, month, day);

  static Date convertToDate(DateTime input){
    return Date(input.year, input.month, input.day);
  }

  static Date today() {
    final now = DateTime.now();
    return Date(now.year, now.month, now.day);
  }
}
