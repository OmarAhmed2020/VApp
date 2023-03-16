class ResendOtpParam{
  bool otpBool;
  String otpKey;

  ResendOtpParam({required this.otpBool, required this.otpKey});

  Map<String, bool> toJson() => {
    otpKey: otpBool,
  };
}