class Validation {
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidTurkishPhoneNumber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(
      r'^5\d{9}$',
    );
    return phoneRegex.hasMatch(phoneNumber);
  }

  static bool isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+.,<>?])[A-Za-z\d!@#$%^&*()_+.,<>?]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}
