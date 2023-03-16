import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:voithy/ui/view/add_dose/add_dose_screen.dart';
import 'package:voithy/ui/view/add_medicine/add_medicine_screens.dart';
import 'package:voithy/ui/view/add_symptoms/add_symptoms_screen.dart';
import 'package:voithy/ui/view/signin/change_password_screen.dart';
import 'package:voithy/ui/view/signin/forget_password_screen.dart';
import 'package:voithy/ui/view/signin/signin_screen.dart';
import 'package:voithy/ui/view/signin/verify_reset_password_screen.dart';
import 'package:voithy/ui/view/singup/verify_account_screen.dart';
import '../ui/view/home/home_screen.dart';
import '../ui/view/medication_list/medication_list_screen.dart';
import '../ui/view/more/more_screen.dart';
import '../ui/view/singup/signup_screen.dart';
import '../ui/view/symptoms__list/symptoms_list_scree.dart';
import '../ui/view/welcome/welcome_screen.dart';
import '../ui/view/welcome/on_boarding_screen.dart';

class AppRouter{
  static appRoutes() => [
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/on_boarding',
      page: () => const OnBoardingScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/welcome',
      page: () => WelcomeScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/sign_up',
      page: () =>  SignUpScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/sign_in',
      page: () =>  SignInScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/forget_password',
      page: () => ForgetPasswordScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/change_password',
      page: () => const ChangePasswordScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/verify_account',
      page: () => const VerifyAccountScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/verify_reset_password',
      page: () => const VerifyResetPasswordScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/add_medicine',
      page: () => AddMedicineScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/add_dose',
      page: () => AddDose(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/add_symptoms',
      page: () => AddSymptomsScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/more_screen',
      page: () => MoreScreen(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/medication_list',
      page: () => MedicationList(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/symptoms_list',
      page: () => SymptomsList(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}