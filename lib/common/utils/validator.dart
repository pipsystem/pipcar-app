class AppValidator {
  static const String _validateEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static RegExp expEmail = RegExp(_validateEmail);

  bool isNullEmpty(Object o) => "" == o;
}
