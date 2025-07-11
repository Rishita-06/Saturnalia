import 'package:intl/intl.dart';

prettyTimestamp(DateTime? timestamp) {
  if (timestamp == null) return 'To Be Announced Soon';

  final formattedDate = DateFormat('d LLL').format(timestamp);
  final formattedTime = DateFormat('jm').format(timestamp);

  return '$formattedTime, $formattedDate';
}

prettyTimeStamp2(DateTime? timestamp) {
  if (timestamp == null) return 'To Be Announced Soon';
  final formattedDate = DateFormat('d LLL').format(timestamp);
  return formattedDate;
}

prettyTimeStamp3(DateTime time) {
  final diff = time.difference(DateTime.now());

  return diff;
}

prettyTimeStamp10(DateTime? timestamp) {
  if (timestamp == null) return 'Time';
  final formattedDate = DateFormat('dd MMM yy, hh:mm a').format(timestamp);
  return formattedDate;
}

prettyTimeStamp4(DateTime? timestamp) {
  if (timestamp == null) return 'Time';
  final formattedDate = DateFormat('hh:mm a').format(timestamp);
  return formattedDate;
}

String prettyTimeStamp5(DateTime? timestamp) {
  // Parse the input date using a specific format
  if (timestamp == null) return 'To Be Announced Soon';

  String formattedDate = DateFormat("dd MMM yy").format(timestamp);
  return formattedDate;
}

String prettyTimeStamp6(DateTime? timestamp) {
  // Parse the input date using a specific format
  if (timestamp == null) return 'Date';

  String formattedDate = DateFormat("dd-MM-yyyy").format(timestamp);
  return formattedDate;
}

String prettyTimeStamp7(String inputString) {
  if (inputString.trim().isEmpty) {
    return '';
  }
  // Parse the input date using a specific format
  final dateTime = DateFormat('dd:MM:yyyy:HH:mm').parse(inputString);

  String formattedDate = DateFormat('dd MMM | HH:mm').format(dateTime);
  return formattedDate;
}

String prettyTimeStamp8(String inputString) {
  DateTime originalDate = DateTime.parse(inputString);
  return DateFormat('dd MMM yyyy').format(originalDate);
}

String prettyTimeStamp9(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }
  // Parse the input date using a specific format

  String formattedDate = DateFormat('dd MMM | hh:mm a').format(dateTime);
  return formattedDate;
}

int prettyTimeStamp12(DateTime dateTime) {
  // Parse the input date using a specific format

  String formattedDate = DateFormat('ddMMyyyyHHmmss').format(dateTime);
  return int.parse(formattedDate);
}
