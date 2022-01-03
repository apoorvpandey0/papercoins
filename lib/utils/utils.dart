import 'package:intl/intl.dart';

String currencyFormatter(number) {
  // log('currencyFormatter: $number');
  if (number == null) {
    return '0';
  }
  if (number is String) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format((double.parse(number)));
  }
  return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(number);
}
