import 'package:intl/intl.dart';

String dateConverter(
    {required String? inputTime, required String outputFormat}) {
  final dateTimeString = inputTime;
  final dateTime = DateTime.parse(dateTimeString!);

  final format = DateFormat(outputFormat);
  final customTime = format.format(dateTime);

  return customTime;
}
