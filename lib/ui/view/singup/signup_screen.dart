import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:voithy/provider/signup_provider.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/signin/signin_screen.dart';
import 'package:voithy/ui/view/singup/terms_conditions_screen.dart';
import 'package:voithy/ui/view/singup/verify_account_screen.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_shawdow_textfield.dart';

class SignUpScreen extends StatelessWidget {
  var SignUpFormKey = GlobalKey<FormState>();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var phone = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: AppColors.colorF6F8FC,
        appBar: getAppBarWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: SignUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.createAccount.tr,
                    textAlign: TextAlign.start,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 18.sp, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadowFormTextField(
                    showStickyLabel: true,
                    labelText: AppStrings.firstName.tr,
                    stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                        size: 15, fontWeight: FontWeight.w700),
                    isMandatory: true,
                    maxLines: 1,
                    isEditable: true,
                    worksAsPopup: false,
                    hintText: AppStrings.firstName.tr,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.required.tr;
                      }
                      return null;
                    },
                    onValueChanged: (value) {
                      signUpProvider.userFirstName = value;
                    },
                    onSaved: (String? value) {
                      signUpProvider.userFirstName = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadowFormTextField(
                    showStickyLabel: true,
                    labelText: AppStrings.lastName.tr,
                    stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                        size: 15, fontWeight: FontWeight.w700),
                    isMandatory: true,
                    maxLines: 1,
                    isEditable: true,
                    worksAsPopup: false,
                    hintText: AppStrings.lastName.tr,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.required.tr;
                      }
                      return null;
                    },
                    onValueChanged: (value) {
                      signUpProvider.userLastName = value;
                    },
                    onSaved: (String? value) {
                      signUpProvider.userLastName = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppStrings.mobileNumber.tr,
                    textAlign: TextAlign.left,
                    style: AppTxtStyles.getAppRegularFont(
                        size: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                            color: AppColors.colorECECEC,
                            width: 1 // red as border color
                            ),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1.2,
                              offset: Offset(0.0, 0.0)),
                        ],
                        color: Colors.white,
                      ),
                      child: IntlPhoneField(
                        textAlign: TextAlign.left,
                        invalidNumberMessage: "",
                        validator: (value) {
                          if (value == null) {
                            return AppStrings.required.tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            isCollapsed: true,
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            counterText: '',
                            counterStyle: const TextStyle(
                              height: double.minPositive,
                            ),
                            alignLabelWithHint: true,
                            disabledBorder: InputBorder.none,
                            hintText: AppStrings.mobileNumber.tr,
                            hintStyle: AppTxtStyles.getAppRegularFont(
                                size: 14, fontWeight: FontWeight.w400)),
                        onChanged: (phone) {
                          signUpProvider.phoneNumber = phone.completeNumber;
                        },
                        onCountryChanged: (country) {},
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadowFormTextField(
                    showStickyLabel: true,
                    labelText: AppStrings.email.tr,
                    stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                        size: 15, fontWeight: FontWeight.w700),
                    isMandatory: true,
                    maxLines: 1,
                    isEditable: true,
                    worksAsPopup: false,
                    hintText: AppStrings.email.tr,
                    validator: (String? value) {
                      signUpProvider.email = value;
                      if (signUpProvider.email == null ||
                          signUpProvider.email!.trim().isEmpty) {
                        return AppStrings.required.tr;
                      } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(signUpProvider.email!)) {
                        return "${AppStrings.enterYourEmailCorrectly.tr} 'Example: Voithy@emailService.com'";
                      } else {
                        if (SignUpFormKey.currentState!.validate()) {
                          signUpProvider.isValidForm = true;
                        }
                        return null;
                      }
                    },
                    onValueChanged: (value) {
                      signUpProvider.email = value;
                      if (signUpProvider.email == null ||
                          signUpProvider.email!.trim().isEmpty) {
                        signUpProvider.isValidForm = false;
                      } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(signUpProvider.email!)) {
                        signUpProvider.isValidForm = false;
                      } else {
                        signUpProvider.isValidForm = true;
                      }
                    },
                    onSaved: (String? value) {
                      signUpProvider.email = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadowFormTextField(
                    showStickyLabel: true,
                    labelText: AppStrings.password.tr,
                    stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                        size: 15, fontWeight: FontWeight.w700),
                    isMandatory: true,
                    maxLines: 1,
                    isEditable: true,
                    worksAsPopup: false,
                    obscureText: true,
                    hintText: AppStrings.password.tr,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.required.tr;
                      }
                      return null;
                    },
                    onValueChanged: (value) {
                      signUpProvider.password = value;
                    },
                    onSaved: (String? value) {
                      signUpProvider.password = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadowFormTextField(
                    showStickyLabel: true,
                    labelText: AppStrings.confirmPassword.tr,
                    stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                        size: 15, fontWeight: FontWeight.w700),
                    isMandatory: true,
                    maxLines: 1,
                    isEditable: true,
                    worksAsPopup: false,
                    obscureText: true,
                    hintText: AppStrings.confirmPassword.tr,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.required.tr;
                      }
                      return null;
                    },
                    onValueChanged: (value) {
                      signUpProvider.confirmPassword = value;
                    },
                    onSaved: (String? value) {
                      signUpProvider.confirmPassword = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                                color: AppColors.color295788, width: 3)),
                        child: Material(
                          child: Consumer<SignUpProvider>(
                            builder: (cntxt, signUpProviderConsumer, wdgt) {
                              return Checkbox(
                                activeColor: AppColors.color295788,
                                checkColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                value: signUpProviderConsumer.agreeTerms,
                                onChanged: (value) {
                                  signUpProvider.agreeTerms = value!;
                                  if (value == false) {
                                    showSnackBar(
                                        context: context,
                                        msg: AppStrings
                                            .pleaseAgreeTermsAndConditions.tr);
                                  } else if (value &&
                                      SignUpFormKey.currentState!.validate()) {
                                    signUpProvider.isValidForm = true;
                                  } else {
                                    showSnackBar(
                                        context: context,
                                        msg: AppStrings
                                            .pleaseFillTheFieldsCorrectly.tr);
                                    signUpProvider.isValidForm = false;
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const TermsConditionsScreen());
                        },
                        child: Text.rich(TextSpan(
                            text: '${AppStrings.iAgreeWithThe.tr} ',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: AppStrings.termsConditions.tr,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.color295788,
                                    fontWeight: FontWeight.w700),
                              ),
                            ])),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<SignUpProvider>(
                      builder: (cntxt, signUpProviderConsumer, wdgt) {
                    return
                      TextButton(
                      style: getDefaultBtnStyle(signUpProvider.isValidForm),
                      onPressed: () {
                        if (SignUpFormKey.currentState!.validate() &&
                            signUpProvider.isValidForm) {
                          if (signUpProviderConsumer.password ==
                              signUpProviderConsumer.confirmPassword) {
                            if (signUpProviderConsumer.agreeTerms) {
                              signUpProvider
                                  .registerNewUser()
                                  .then(((response) {
                                if (response.apiStatus! == true) {
                                  Get.to(const VerifyAccountScreen());
                                } else {
                                  showSnackBar(
                                      context: context,
                                      msg: "${response.message?.tr}");
                                }
                              }));
                            } else {
                              showSnackBar(
                                  context: context,
                                  msg: AppStrings
                                      .pleaseAgreeTermsAndConditions.tr);
                            }
                          } else {
                            showSnackBar(
                                context: context,
                                msg: AppStrings.passwordsDontMatch.tr);
                          }
                        } else {
                          signUpProvider.isValidForm = false;
                          showSnackBar(
                              context: context,
                              msg: AppStrings.pleaseFillTheFieldsCorrectly.tr);
                        }
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(AppStrings.signUp.tr,
                            textAlign: TextAlign.center,
                            style: getBtnTxtStyle(signUpProvider.isValidForm)),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(SignInScreen());
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text.rich(TextSpan(
                          text: AppStrings.alreadyAMember.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16, fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: AppStrings.signIn.tr,
                              style: AppTxtStyles.getAppRegularFont(
                                      size: 16, fontWeight: FontWeight.w500)
                                  .copyWith(color: AppColors.color295788),
                            ),
                          ])),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
