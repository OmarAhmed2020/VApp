class EmailBody{
  String? _email;

  EmailBody(this._email);

  Map<String, dynamic> toJson() => {
    "email": _email,
  };
}