class Environment {
  static final Environment _instance = Environment._privateConstructor();

  Environment._privateConstructor();

  String environment;
  String version;

  factory Environment() {
    return _instance;
  }
}
