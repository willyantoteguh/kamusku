class AppConstants {
  const AppConstants();

  static BaseEnvironment baseEnvironment = const BaseEnvironment();
}

class BaseEnvironment {
  const BaseEnvironment();

  String get baseUrl => "https://api.dictionaryapi.dev/api/v2/entries/en/";
}
