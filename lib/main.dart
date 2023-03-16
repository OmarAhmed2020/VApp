import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voithy/provider/add_medicine_provider.dart';
import 'package:voithy/provider/reset_password_provider.dart';
import 'package:voithy/provider/signin_provider.dart';
import 'package:voithy/provider/signup_provider.dart';
import 'package:voithy/router/router.dart';
import 'package:voithy/ui/localization/languages.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'package:voithy/ui/view/welcome/welcome_screen.dart';
import 'ui/localization/locale_controller.dart';
import 'package:flutter/services.dart';

late SharedPreferences shardpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shardpref = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SignUpProvider()),
      ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
      ChangeNotifierProvider(create: (_) => SignInProvider()),
      ChangeNotifierProvider(create: (_) => AddMedicineProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Get.put(LocaleController());
    LocaleController controller = Get.put(LocaleController());
    final addMedicineProvider = Provider.of<AddMedicineProvider>(context, listen: false);
    addMedicineProvider.weekDaysList = addMedicineProvider.getWeekDaysList();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: Languages(),
          locale: controller.inialLanguage,
          fallbackLocale: const Locale('en', 'US'),
          title: 'Voithy',
          initialRoute: '/home',
          getPages: AppRouter.appRoutes(),
          theme: ThemeData(
            primarySwatch: MaterialColor(900, AppColors.getSwatch(AppColors.color295788)),
            fontFamily: 'Roboto_Reg',
          ),
          home: WelcomeScreen(),
        );
      },
    );
  }
}
