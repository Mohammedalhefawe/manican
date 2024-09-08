import 'package:intl/intl.dart';

String formatTime(String time) {
  // Parse the input time string into a DateTime object
  final DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
  // Format the DateTime object to a 12-hour format with AM/PM
  return DateFormat("hh:mm a").format(parsedTime);
}

String formatDateTime(String input) {
  // Parse the input string to DateTime
  DateTime dateTime = DateTime.parse(input);

  // Create a DateFormat object for the desired output format
  DateFormat outputFormat = DateFormat('h:mm a', 'ar');

  // Format the DateTime to the desired string
  String formatted = outputFormat.format(dateTime);

  return formatted;
}

String formatDate(String inputDate) {
  try {
    DateTime date = DateTime.parse(inputDate);
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    print('Error parsing date: $e');
    return inputDate; // Return original string if parsing fails
  }
}

String formatArabicTime(
  String timeString,
) {
  if (timeString.isEmpty) {
    return "غير محدد";
  }
  // Parse the input time string
  DateTime time = DateFormat("HH:mm:ss").parse(timeString);

  // Format the time in 12-hour format
  String formattedTime = DateFormat('hh:mm a').format(time);

  // Replace AM/PM with Arabic characters
  formattedTime = formattedTime.replaceAll('AM', 'ص').replaceAll('PM', 'م');

  return formattedTime;
}

String formatArabicTimeEdit(String timeString) {
  if (timeString.isEmpty) {
    return "غير محدد";
  }
  // Parse the input time string
  DateTime time = DateFormat("HH:mm:ss").parse(timeString);

  // Format the time in 12-hour format
  String formattedTime = DateFormat('hh:mm a').format(time);

  // Replace AM/PM with Arabic characters
  formattedTime = formattedTime.replaceAll('AM', 'ص').replaceAll('PM', 'م');

  // Ensure correct RTL display
  return '\u200F$formattedTime';
}

String convertTimeFormatForBackEnd(String inputTime) {
  // Detect if the inputTime contains Arabic AM/PM indicators
  bool isArabic = inputTime.contains('ص') || inputTime.contains('م');

  // Replace Arabic AM/PM with English equivalents
  if (isArabic) {
    inputTime = inputTime.replaceAll('ص', 'AM').replaceAll('م', 'PM');
  }

  // Parse the input time string to DateTime
  DateFormat inputFormat = DateFormat.jm(); // jm() is for "9:21 PM"
  DateTime dateTime = inputFormat.parse(inputTime);

  // Format the DateTime to the desired format
  DateFormat outputFormat = DateFormat('HH:mm:ss'); // Desired format "05:10:10"
  String formattedTime = outputFormat.format(dateTime);

  return formattedTime;
}
