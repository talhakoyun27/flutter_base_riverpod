class LocaleKeyParam {
  final LocalKeys key;

  LocaleKeyParam(this.key);
}

enum LocalKeys {
  isDarkModeEnabled("isDarkModeEnabled"),
  loginInfo("loginInfo");

  final String value;
  const LocalKeys(this.value);
}
