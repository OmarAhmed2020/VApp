import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/theme/app_txt_styles.dart';
import 'package:voithy/ui/view/home/home_screen.dart';
import 'package:voithy/ui/view/signin/forget_password_screen.dart';
import 'package:voithy/ui/view/singup/signup_screen.dart';
import 'package:voithy/ui/view/widgets/app_bar_widget.dart';
import '../../../provider/signin_provider.dart';
import '../../../provider/signup_provider.dart';
import '../../../r.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_shawdow_textfield.dart';
import '../widgets/social_button_widget.dart';

class SignInScreen extends StatelessWidget {
  var signInformKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.colorF6F8FC,
      appBar: getAppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: signInformKey,
              child: Consumer<SignInProvider>(
                  builder: (cntxt, signInProviderConsumer, wdget) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.signIn.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 18.sp, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomShadowFormTextField(
                      textEditingController: emailController,
                      showStickyLabel: true,
                      labelText: AppStrings.email.tr,
                      stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                          size: 15, fontWeight: FontWeight.w700),
                      isMandatory: true,
                      maxLines: 1,
                      isEditable: true,
                      worksAsPopup: false,
                      obscureText: false,
                      hintText: AppStrings.pleaseEnterYourEmailAddress.tr,
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppStrings.required.tr;
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(value)) {
                          return "${AppStrings.enterYourEmailCorrectly.tr}  'Voithy@gmail.com'";
                        }
                        return null;
                      },
                      onValueChanged: (value) {
                        signInProvider.email = value;
                      },
                      onSaved: (String? value) {
                        signInProvider.email = value;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomShadowFormTextField(
                      textEditingController: passwordController,
                      showStickyLabel: true,
                      labelText: AppStrings.password.tr,
                      stickyLabelStyle: AppTxtStyles.getAppRegularFont(
                          size: 15, fontWeight: FontWeight.w700),
                      isMandatory: true,
                      maxLines: 1,
                      isEditable: true,
                      worksAsPopup: false,
                      obscureText: true,
                      hintText: AppStrings.pleaseEnterYourPassword.tr,
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppStrings.required.tr;
                        }
                        return null;
                      },
                      onValueChanged: (value) {
                        signInProvider.password = value;
                        if (value!.isNotEmpty &&
                            signInProvider.email!.isNotEmpty) {
                          signInProvider.isValidForm = true;
                        } else {
                          signInProvider.isValidForm = false;
                        }
                      },
                      onSaved: (String? value) {
                        signInProvider.password = value;
                        if (value!.isNotEmpty &&
                            signInProvider.email!.isNotEmpty) {
                          signInProvider.isValidForm = true;
                        } else {
                          signInProvider.isValidForm = false;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen()),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                            text: AppStrings.forgotYourPassword.tr,
                            style: AppTxtStyles.getAppRegularFont(
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ).copyWith(color: AppColors.color295788)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Consumer<SignUpProvider>(
                        builder: (cotxt, signUpProviderConsumer, widget) {
                      return TextButton(
                        style: getDefaultBtnStyle(signInProvider.isValidForm),
                        onPressed: () {
                          if (signInformKey.currentState!.validate()) {
                            signInProvider.signInUser().then(((response) {
                              if (response.apiStatus! == true) {
                                //signInProvider.isValidForm = false;
                                Get.to(const HomeScreen());
                                signInProvider.dispose();
                              } else {
                                signInProvider.isValidForm = false;
                                showSnackBar(
                                    context: context,
                                    msg:
                                        "${AppStrings.apiError.tr}ErrorMsg: ${response.message?.tr}.");
                              }
                            }));
                          } else {
                            showSnackBar(
                                context: context,
                                msg:
                                    AppStrings.pleaseFillTheFieldsCorrectly.tr);
                          }
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(AppStrings.signIn.tr,
                              textAlign: TextAlign.center,
                              style:
                                  getBtnTxtStyle(signInProvider.isValidForm)),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: Text.rich(TextSpan(
                          text: AppStrings.dontHaveAccount.tr,
                          style: AppTxtStyles.getAppRegularFont(
                              size: 16, fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: AppStrings.signUp.tr,
                              style: AppTxtStyles.getAppRegularFont(
                                      size: 16, fontWeight: FontWeight.w500)
                                  .copyWith(color: AppColors.color295788),
                            ),
                          ])),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: 75.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)),
                          child: const Text(""),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(AppStrings.orContinueWith.tr),
                        ),
                        Container(
                          child: const Text(""),
                          height: 1,
                          width: 75.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomWidgets.socialButtonRect(
                        AppStrings.connectWithFacebook.tr,
                        AppColors.facebookColor,
                        Colors.white,
                        R.assetsIconsFacebook,
                        onTap: () {
                          showSnackBar(
                              context: context,
                              msg:
                              AppStrings.comingSoon.tr);
                        }),
                    CustomWidgets.socialButtonRect(
                        "${AppStrings.connectWithGoogle.tr}    ",
                        Colors.white,
                        Colors.black87,
                        R.assetsIconsGoogleLogo,
                        onTap: () {
                          showSnackBar(
                              context: context,
                              msg:
                              AppStrings.comingSoon.tr);
                        }),
                  ],
                );
              })),
        ),
      ),
    );
  }
}
