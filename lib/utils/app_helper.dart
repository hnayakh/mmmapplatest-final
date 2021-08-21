class AppHelper {
  static String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static List<int> getHeights() {
    List<int> heights = [];
    for (int i = 167; i <= 243; i++) {
      heights.add(i);
    }
    return heights;
  }
}
