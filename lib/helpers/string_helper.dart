class StringHelper {
  static String getFirstName(String fullName) {
    String shortName = "";
    if (fullName.isNotEmpty) {
      final listName = fullName.split(" ");

      for (int i = 0; i < listName.length; i++) {
        shortName = shortName + listName[i][0];
      }
    }

    return shortName;
  }
}
