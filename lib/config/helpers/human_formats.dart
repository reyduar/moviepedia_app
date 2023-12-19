import 'package:intl/intl.dart';
import 'package:moviepedia_app/config/helpers/date_time_extension.dart';

class HumanFormats {
  static String number(double number, [int decimals = 0]) {
    return NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: '', locale: 'en')
        .format(number);
  }

  static String shortDate(DateTime date) {
    final format = DateTime.now().format('dd/MM/yyyy', 'es');
    return format;
  }
}
