
class Environment {

  static final Environment _instance = Environment._privateConstructor();
  Environment._privateConstructor();


  String environment;


  factory Environment() {
    return _instance;
  }


}