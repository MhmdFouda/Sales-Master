import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'date_time_formater.g.dart';

@riverpod
String dateFormater(DateFormaterRef ref, DateTime dateTime) =>
    DateFormat('yyyy-MM-dd').format(dateTime);

@riverpod
String timeFormater(TimeFormaterRef ref, DateTime dateTime) =>
    DateFormat('h:mm a').format(dateTime);
