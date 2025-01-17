// converting data time into string yyymmdd

String convertDateTimeToString(DateTime dateTime){
  //year in format -yyyy

  String year = dateTime.year.toString();

  //month in format -mm
  String month = dateTime.month.toString();

  if (month.length == 1){
    month = '0$month';
  }

  //day in format -dd
  String day = dateTime.day.toString();
  if(day.length == 1){
    day = '0$day';
  }

  //final format

  String yyyymmdd = year + month + day ;
  return yyyymmdd;
}