import 'package:intl/intl.dart';

class DateHelper {
  static String formatDateToString(DateTime datetime) {
    var formatter = new DateFormat('dd MMMM, yyyy');
    String dateFormatted = formatter.format(datetime);

    return dateFormatted.substring(0, 2) + " de" + dateFormatted.substring(2, dateFormatted.length);
  }

  static String? calculateHowMuchTimeIsLeft(DateTime dateTime) {
    final difference = dateTime.difference(DateTime.now()).inDays;
    if (difference <= 0) return "";
    if (difference < 30) return "Faltam $difference dias";
    if (difference >= 30) {
      int valueInMonths = difference ~/ 30;
      if (valueInMonths > 1) return "Faltam $valueInMonths meses";
      return "Falta $valueInMonths mês";
    }
  }

  static String textFieldString(DateTime date) {
    return "${date.toLocal().day}/${date.toLocal().month}/${date.toLocal().year}";
  }
}
