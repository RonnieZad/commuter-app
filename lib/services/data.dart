import 'package:intl/intl.dart';

main() {
  var now = DateTime.now();
  var year = DateTime.now().year;

  var month = DateTime.now().month;

  var week = DateTime.now().weekday;
  var date = DateFormat.MMMd().format(now);

  //var date = DateFormat.MONTH_WEEKDAY_DAY;

  print(week);
}
