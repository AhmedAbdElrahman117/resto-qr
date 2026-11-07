import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toShortDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String toDateTimeShort() {
    return DateFormat('dd/MM/yyyy hh:mm a').format(this);
  }
}
