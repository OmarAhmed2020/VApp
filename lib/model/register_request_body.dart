class RegisterBody{
  String? _email;
  String? _phoneNumber;
  String? _userFirstName;
  String? _userLastName;
  String? _password;

  RegisterBody(this._email, this._phoneNumber, this._userFirstName,
      this._userLastName, this._password);

  Map<String, dynamic> toJson() => {
    "firstName": _userFirstName,
    "lastName": _userLastName,
    "password": _password,
    "phone": _phoneNumber,
    "email": _email,
  };
}