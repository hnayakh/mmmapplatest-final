import 'package:intl/intl.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class Height {
  int feet;
  int inch;
  Height(this.feet, this.inch);
}

class AppHelper {
  static String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  // static List<double> getHeights() {
  //   List<double> heights = [];
  //   //convert to ft in change
  //   for (double i = 4.5; i <= 8.5; i += 0.1) {
  //     heights.add(i);
  //   }
  //   return heights;
  // }

  static List<String> getHeights() {
    List<Height> result = [];
    var requiredIndices = [];

    for (double i = 4.5; i <= 8.5; i += 0.1) {
      var intPart = i.toInt();
      var decimalPart = ((i - i.toInt()) * 10).round();
      print('decimalPart$decimalPart');
      var item = new Height(intPart, decimalPart);
      result.add(item);
      if (decimalPart == 9) {
        var requiredIndex = result.indexWhere(
            (item) => item.feet == intPart && item.inch == decimalPart);
        print('requiredIndex$requiredIndex');

        result.add(new Height(intPart, 11));
        result.add(new Height(intPart + 1, 0));
      }
    }
    result.sort((a, b) =>
        (((a.feet * 12 + (a.inch)) - (b.feet * 12 + (b.inch))).toInt()));

    var finalResult = result.map((height) {
      return "${height.feet}.${(height.inch)}";
    });
    print(finalResult);
    //var heights = finalResult;
    return finalResult.toList();
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

  static getReadableDateTIme(String dateOfBirth) {
    DateFormat dateFormat1 = DateFormat("yyyy-MM-dd HH:mm:ss");
    var date = dateFormat1.parse(dateOfBirth);
    print(date.toString());
    DateFormat dateFormat2 = DateFormat("dd MMM yyyy HH:mm");
    return dateFormat2.format(date);
  }

  static getReadableDateTImeFromServer(String dateOfBirth) {
    DateFormat dateFormat1 = DateFormat(AppConstants.SERVERDATEFORMAT);
    var date = dateFormat1.parse(dateOfBirth);
    print(date.toString());
    DateFormat dateFormat2 = DateFormat("dd MMM yyyy HH:mm");
    return dateFormat2.format(date);
  }

  static String serverFormatDate(DateTime dateOfBirth) {
    DateFormat dateFormat1 = DateFormat(AppConstants.SERVERDATEFORMAT);
    return dateFormat1.format(dateOfBirth);
  }

  static String getHeight(index) {
    String heightFitInch = AppHelper.getHeights()[index];
    double heightCm = (double.parse(heightFitInch.split(".")[0]) * 30.48) +
        (double.parse(heightFitInch.split(".")[1]) * 2.54);
    heightCm.round();
    print(heightCm);
    // String heightText =
    //     '$heightFitInch ft';
    return (heightFitInch.split(".")[0] +
        "' " +
        '.' +
        heightFitInch.split(".")[1] +
        '"' +
        " (${heightCm.round()}" +
        " cm)");
  }

  static String getStringFromEnum(enumEntry) {
    var enumName = enumEntry.toString().split('.').first;
    if (enumName == 'MaritalStatus') {
      List<String> maritalStatuses = [
        'Never Married',
        'Divorced',
        'Widowed',
        'Awaiting Divorce'
      ];
      return maritalStatuses[enumEntry.index];
    } else if (enumName == 'MaritalStatusFilter') {
      List<String> maritalFilter = [
        'Doesnot Matter',
        'Never Married',
        'Divorced',
        'Widowed',
        'Awaiting Divorce'
      ];
      return maritalFilter[enumEntry.index];
    } else if (enumName == 'Interest') {
      List<String> interestFilter = [
        'DoesnotMatter',
        'Sports',
        'Travel',
        'Photography',
        'Gaming',
        'Singing',
        'Dance',
        'Food',
        'Music',
        'Art',
        'Cooking',
        'Fashion',
        'vblogging',
        'Animals',
        'Nature',
        'Tech',
        'Social'
      ];
      return interestFilter[enumEntry.index];
    } else if (enumName == 'AbilityStatus') {
      List<String> abilityStatus = [
        'Normal',
        'Physically Challenged',
      ];
      return abilityStatus[enumEntry.index];
    } else if (enumName == 'ChildrenStatus') {
      List<String> childrenStatus = [
        'No',
        'Yes,living together',
        'Yes,not living together'
      ];
      return childrenStatus[enumEntry.index];
    } else if (enumName == 'EatingHabit') {
      List<String> eatingStatus = [
        'Vegetarrian',
        'Eggitarrian',
        'Nonvegetarrian',
      ];
      return eatingStatus[enumEntry.index];
    } else if (enumName == 'EatingHabitFilter') {
      List<String> eatingFilterStatus = [
        'Doesnot matter'
            'Vegetarrian',
        'Eggitarrian',
        'Nonvegetarrian',
      ];
      return eatingFilterStatus[enumEntry.index];
    } else if (enumName == 'SmokingHabit') {
      List<String> smokingStatus = [
        'Smoker',
        'NonSmoker',
        'Occasionally',
      ];
      return smokingStatus[enumEntry.index];
    } else if (enumName == 'SmokingHabitFilter') {
      List<String> smokingFilterStatus = [
        'Doesnot matter'
            'Smoker',
        'NonSmoker',
        'Occasionally',
      ];
      return smokingFilterStatus[enumEntry.index];
    } else if (enumName == 'DrinkingHabit') {
      List<String> drinkingStatus = [
        'Alcoholic',
        'Non alcoholic',
        'Occasionally',
      ];
      return drinkingStatus[enumEntry.index];
    } else if (enumName == 'DrinkingHabitFilter') {
      List<String> drinkingFilterStatus = [
        'Doesnot matter'
            'Alcoholic',
        'Non alcoholic',
        'Occasionally',
      ];
      return drinkingFilterStatus[enumEntry.index];
    } else if (enumName == 'AnualIncome') {
      List<String> incomes = [
        'No Income',
        '0-1 lakh',
        '1-2 lakh',
        '2-3 lakh',
        '3-4 lakh',
        '4-5 lakh',
        '5-7.5 lakh',
        '7.5-10 lakh',
        '10-15 lakh',
        '15-20 lakh',
        '20-25 lakh',
        '25-35 lakh',
        '35-50 lakh',
        '50-75 lakh',
        '75 lakh- 1 crore',
        '1 crore and above'
      ];
      return incomes[enumEntry.index];
    } else if (enumName == 'FamilyAfluenceLevel') {
      List<String> familyLevel = [
        'Rich',
        'Upper middle class',
        'Middle class',
        'Lower middle class'
      ];
      return familyLevel[enumEntry.index];
    } else if (enumName == 'NoOfChildren') {
      List<String> children = ['One', 'Two', 'Three or more'];
      return children[enumEntry.index];
    } else if (enumName == 'FatherOccupation') {
      List<String> fatherOcc = [
        'Employed',
        'Business Man',
        'Retired',
        'Not employed',
        'Passed away'
      ];
      return fatherOcc[enumEntry.index];
    } else if (enumName == 'MotherOccupation') {
      List<String> motherOcc = [
        'Homemaker',
        'Employed',
        'Business woman',
        'Retired',
        'Passed away'
      ];
      return motherOcc[enumEntry.index];
    }

    // else if (enumName == 'NoOfChildren') {
    //   List<String> noOfChildren = ['One', 'Two', 'ThreeOrMore'];
    //   return noOfChildren[enumEntry.index];
    // }

    else {
      return '';
    }
  }

  static String getTimeGone(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime myDate = dateFormat.parse(date);
    var difference = DateTime.now().difference(myDate).inMinutes;
    if (difference >= 60 * 24 * 30) {
      var month = (difference / 60 / 24 / 30).round();
      return "${month.round()} ${month > 1 ? 'months' : 'month'} ago";
    } else if (difference >= 60 * 24) {
      var day = difference / 60 / 24;
      print("days:${day.round()}");
      return "${day.round()} ${day.round() > 1 ? 'days' : 'day'} ago";
    } else if (difference >= 60) {
      return "${(difference / 60).round()}hr ago";
    } else if (difference > 1) {
      return "${difference}m ago";
    } else {
      return "Now";
    }
  }
}
