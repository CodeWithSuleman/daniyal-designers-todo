class Validator {
  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }
}
