class EmailPasswordBody{
  String? _email;
  String? _password;

  EmailPasswordBody(this._email,this._password);

  Map<String, dynamic> toJson() => {
    "email": _email,
    "password": _password,
  };
}