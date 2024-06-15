//extension to check if the email is valid or not
extension EmailValidator on String {
  bool isValidEmail() {
    final RegExp regex = RegExp(
      r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b',
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(this);
  }
}

//extension to check if the user name is valid
extension UsernameValidator on String {
  bool isValidUsername() {
    return length >= 3 &&
        !RegExp(r'^\d+$').hasMatch(this);
  }
}

//extension to check if the passowrd contains uppercase letters
extension UpperCaseValidator on String {
  bool isUpperCase() {
    return contains(RegExp(r'[A-Z]'));
  }
}
//extension to check if the passowrd contains lowercase letters
extension LowerCaseValidator on String {
  bool isLowerCase() {
    return contains(RegExp(r'[a-z]'));
  }
}
//extension to check if the passowrd contains atleast 1 digit
extension DigitValidator on String {
  bool isContainDigit() {
    return contains(RegExp(r'[0-9]'));
  }
}
//extension to check if the passowrd contains a special character
extension SpecialCharacterValidator on String {
  bool isContainSpecialCharacter() {
    return contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }
}


