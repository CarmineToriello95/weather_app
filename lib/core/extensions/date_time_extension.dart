import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get longDay => DateFormat('EEEE').format(this);
  String get shortDay => DateFormat('E').format(this);
}
