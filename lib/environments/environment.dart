class Environment {
  static Environment value;

  String env;
  String baseUrl;
  String firstPage;

  Environment() {
    value = this;
  }

  String get name => runtimeType.toString();
}
