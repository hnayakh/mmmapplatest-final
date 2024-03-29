import 'package:intl/intl.dart';
import 'package:makemymarry/utils/app_constants.dart';

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

  static String heightString(double height) {
    return "${(height ~/ 12)}'${(height % 12).toInt()}''";
  }

  // static List<double> getHeights() {
  //   List<double> heights = [];
  //   //convert to ft in change
  //   for (double i = 4.5; i <= 8.5; i += 0.1) {
  //     heights.add(i);
  //   }
  //   return heights;
  // }
  static String getFormtedHeight(double height) {
    var intPart = height.toInt();
    var decimalPart = ((height - height.toInt()) * 10).round();

    String result = '$intPart.$decimalPart';
    if (intPart > 4 && decimalPart < 2) {
      result = '${intPart - 1}.${10 + decimalPart}';
    }
    if (intPart > 4 && decimalPart == 2) {
      result = '${intPart}.0';
    }
    return result;
  }

  static List<String> getHeights() {
    List<Height> result = [];
    for (double i = 48; i <= 84; i++) {
      var intPart = i ~/ 12;
      var decimalPart = (i % 12).toInt();
      var item = new Height(intPart, decimalPart);
      result.add(item);
    }
    var finalResult = result.map(
      (height) {
        return "${height.feet}${(height.inch)}";
      },
    );
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

  static String getLabelOfComparitiveField(String field) {
    switch (field) {
      case "country":
        {
          return "Country";
        }
      case "challenged":
        {
          return "Physically Ability";
        }
      case "minAge":
        {
          return "Min Age";
        }
      case "maxAge":
        {
          return "Max Age";
        }
      case "minHeight":
        {
          return "Min Height";
        }
      case "maxHeight":
        {
          return "Max Height";
        }
      case "maritalStatus":
        {
          return "Marital Status";
        }
      case "religion":
        {
          return "Religion";
        }
      case "motherTongue":
        {
          return "Mother Tongue";
        }
      case "caste":
        {
          return "Caste";
        }
      case "caste":
        {
          return "Caste";
        }
      case "occupation":
        {
          return "Occupation";
        }
      case "highestEducation":
        {
          return "Education";
        }
      case "dietaryHabits":
        {
          return "Eating Habits";
        }
      case "smokingHabits":
        {
          return "Smoking Habits";
        }
      case "drinkingHabits":
        {
          return "Drinking Habits";
        }
      case "maxIncome":
        {
          return "Max Income";
        }
      case "minIncome":
        {
          return "Min Income";
        }
    }
    return field;
  }

  static String getAgeFromDob(String dateOfBirth) {
    DateFormat dateFormat = DateFormat(AppConstants.SERVERDATEFORMAT);
    var date =
        dateFormat.parse(dateOfBirth.isEmpty ? "2000-01-01" : dateOfBirth);
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

  static String getHeight(int index) {
    var inches = index + 48;
    return ((inches ~/ 12).toString() +
        "' " +
        ((inches % 12).toInt().toString()) +
        '"' +
        " (${(inches * 2.54).round()}" +
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
        'Does not Matter',
        'Never Married',
        'Divorced',
        'Widowed',
        'Awaiting Divorce'
      ];
      return maritalFilter[enumEntry.index];
    } else if (enumName == 'Interest') {
      List<String> interestFilter = [
        'Does not Matter',
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
        'Vlogging',
        'Animals',
        'Nature',
        'Tech',
        'Social'
      ];
      return interestFilter[enumEntry.index];
    } else if (enumName == 'InterestFilter') {
      List<String> interestFilter = [
        'Does not Matter',
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
        'vlogging',
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
        'Not Specified',
        'Vegetarian',
        'Eggetarian',
        'Non Vegetarian',
      ];
      return eatingStatus[enumEntry.index];
    } else if (enumName == 'EatingHabitFilter') {
      List<String> eatingFilterStatus = [
        'Does not matter',
        'Vegetarian',
        'Eggetarian',
        'Non Vegetarian',
      ];
      return eatingFilterStatus[enumEntry.index];
    } else if (enumName == 'SmokingHabit') {
      List<String> smokingStatus = [
        'Not Specified',
        'Smoker',
        'Non Smoker',
        'Occasionally',
      ];
      return smokingStatus[enumEntry.index];
    } else if (enumName == 'SmokingHabitFilter') {
      List<String> smokingFilterStatus = [
        'Does not matter',
        'Smoker',
        'NonSmoker',
        'Occasionally',
      ];
      return smokingFilterStatus[enumEntry.index];
    } else if (enumName == 'DrinkingHabit') {
      List<String> drinkingStatus = [
        'Not Specified',
        'Alcoholic',
        'Non alcoholic',
        'Occasionally',
      ];
      return drinkingStatus[enumEntry.index];
    } else if (enumName == 'DrinkingHabitFilter') {
      List<String> drinkingFilterStatus = [
        'Does not matter',
        'Alcoholic',
        'Non alcoholic',
        'Occasionally',
      ];
      return drinkingFilterStatus[enumEntry.index];
    } else if (enumName == 'AnnualIncome') {
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
        '1 crore and above',
        'Not Mentioned'
      ];
      return incomes[enumEntry.index];
    } else if (enumName == 'FamilyAfluenceLevel') {
      List<String> familyLevel = [
        'Affluent',
        'Upper Middle Class',
        'Middle Class',
        'Lower Middle Class',
        'Not Mentioned'
      ];
      return familyLevel[enumEntry.index];
    } else if (enumName == 'FamilyValues') {
      List<String> familyValue = [
        'Orthodox',
        'Conservative',
        'Moderate',
        'Liberal',
        'Not Mentioned'
      ];
      return familyValue[enumEntry.index];
    } else if (enumName == 'FamilyType') {
      List<String> familyValue = [
        'Nuclear',
        'Joint',
        'Other',
        'Not Mentioned',
      ];
      return familyValue[enumEntry.index];
    } else if (enumName == 'NoOfChildren') {
      List<String> children = ['One', 'Two', 'Three or more'];
      return children[enumEntry.index];
    } else if (enumName == 'FatherOccupation') {
      List<String> fatherOcc = [
        'Employed',
        'Business Man',
        'Retired',
        'Not employed',
        'Passed away',
        'Not Mentioned'
      ];
      return fatherOcc[enumEntry.index];
    } else if (enumName == 'MotherOccupation') {
      List<String> motherOcc = [
        'Homemaker',
        'Employed',
        'Business woman',
        'Retired',
        'Passed away',
        'Not Mentioned'
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
