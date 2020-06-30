class StringUtils {
  static String capitalize(String input) {
    return input.isEmpty
        ? input
        : (input[0].toUpperCase() + input.substring(1));
  }

  static String titleCase(String input) {
    return input
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
