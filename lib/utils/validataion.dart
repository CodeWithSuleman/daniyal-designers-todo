class Validator {
  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your Phone Number';
    }
    return null;
  }

  static String? validateHeight(String? value) {
    if (value!.isEmpty) {
      return 'Please enter Height';
    }
    return null;
  }

  static String? validateWaist(String? value) {
    if (value!.isEmpty) {
      return 'Please enter Waist';
    }
    return null;
  }
}
