extension ValidatorExtensions on String? {
  ///
  /// [ emptyValidation ]
  String? emptyValidation() {
    if (this == null || this!.isEmpty) {
      return "*";
    }
    return null;
  }

  ///
  /// [ required ]
  String? required() {
    if (this == null || this!.isEmpty) {
      return "* Required";
    }
    return null;
  }

  String? numberValidation() {
    String value = this ?? "";
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length != 10) {
      return "Must be 10 digits";
    } else if (!(value.startsWith("97") ||
        value.startsWith("98") ||
        value.startsWith("96"))) {
      return "Invalid Number";
    }
    return null;
  }

  ///
  ///
  String? passwordValidation() {
    // RegExp regex =
    //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$');
    var passNonNullValue = this ?? "";
    if (passNonNullValue.isEmpty) {
      return ("* Required");
    } else if (passNonNullValue.length < 5) {
      return ("Password Must be more than 5 characters");
      // } else if (!regex.hasMatch(passNonNullValue)) {
      //   return ("Invalid Password ");
    }
    return null;
  }

  String? confirmPasswordValidation(String password) {
    if (this == null || this!.isEmpty) {
      return "* Required";
    }
    if (this != password) {
      return "Password doesnot match";
    }
    return null;
  }
}
