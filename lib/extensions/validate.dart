extension StringExtension on String {
  bool isEmail() {
    var reg = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$').hasMatch(this);
    return reg;
  }

  String isPasswordValid() {
    if (this.length < 8) return 'Password should not be less than 8 characters';
    if (!this.contains(RegExp(r"[a-z]")))
      return 'Password should contain atleast 1 lowercase letter';
    if (!this.contains(RegExp(r"[A-Z]")))
      return 'Password should contain atleast 1 uppercase letter';
    if (!this.contains(RegExp(r"[0-9]")))
      return 'Password should contain atleast 1 digit';
    if (!this.contains(RegExp(r'[!@#$%^&£*(),.?":{}|<>]')))
      return 'Password should contain atleast 1 special character';
    return '';
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return '';
  }
}
