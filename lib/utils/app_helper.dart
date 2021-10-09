import 'package:intl/intl.dart';
import 'package:makemymarry/utils/app_constants.dart';

class AppHelper {
  static String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static List<double> getHeights() {
    List<double> heights = [];
    //convert to ft in change
    for (double i = 4.5; i <= 8.5; i += 0.1) {
      heights.add(i);
    }
    return heights;
  }

  static List<dynamic> getHeightsFilter() {
    List<dynamic> heights = [];
    //convert to ft in change
    for (double i = 4.5; i <= 8.5; i += 0.1) {
      heights.add(i);
    }
    heights.insert(0, 'Doesnot Matter');
    return heights;
  }

  static String getAgeFromDob(String dateOfBirth) {
    DateFormat dateFormat = DateFormat(AppConstants.SERVERDATEFORMAT);
    var date = dateFormat.parse(dateOfBirth);
    return (DateTime.now().difference(date).inDays / 365).round().toString();
  }

  static getReadableDob(String dateOfBirth) {
    DateFormat dateFormat1 = DateFormat(AppConstants.SERVERDATEFORMAT);
    var date = dateFormat1.parse(dateOfBirth);
    DateFormat dateFormat2 = DateFormat("dd MMM,yyyy");
    return dateFormat2.format(date);
  }

  static String serverFormatDate(DateTime dateOfBirth) {
    DateFormat dateFormat1 = DateFormat(AppConstants.SERVERDATEFORMAT);
    return dateFormat1.format(dateOfBirth);
  }
}
