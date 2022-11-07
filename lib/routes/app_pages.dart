import 'package:get/get.dart';
import 'package:modul6_task3/routes/app_rountes.dart';
import 'package:modul6_task3/src/presentation/pages/minyu/minyu.dart';
import 'package:modul6_task3/src/presentation/pages/uy_ishi1.2account_class/account_class.dart';
import 'package:modul6_task3/src/presentation/pages/chernovek/hive.dart';
import 'package:modul6_task3/src/presentation/pages/uy_ishi2.1user_accaount/user_accaunt2.1.dart';
import 'package:modul6_task3/src/presentation/pages/uy_ishi1.1user_class/usser_class.dart';
import 'package:modul6_task3/src/presentation/pages/uy_ishi2.2user_accaunt/user_accaunt2.2.dart';
import 'package:modul6_task3/src/presentation/pages/uy_ishi3.1signin/sign_in_1.dart';
import 'package:modul6_task3/src/presentation/pages/uy_ishi3.2signup/signup2.dart';

class AppPages {
  static final getPages = [
    GetPage(
      name: AppRoutes.userClass,
      page: () =>  const MyUserClass(),
    ),
    GetPage(
      name: AppRoutes.AccountClass,
      page: () =>  const MyAccauntClass(),
    ),
    GetPage(
      name: AppRoutes.chernovek,
      page: () =>  const MyChernovek(),
    ),
    GetPage(
      name: AppRoutes.userAccaunt,
      page: () =>  const MyUserAccount(),
    ),
    GetPage(
      name: AppRoutes.userAccaunt2,
      page: () =>  const MyUserAccount2(),
    ),
    GetPage(
      name: AppRoutes.minyu,
      page: () =>  const MyMinyu(),
    ),
    GetPage(
      name: AppRoutes.signin1,
      page: () =>  const MySignIn1(),
    ),
    GetPage(
      name: AppRoutes.signup2,
      page: () =>  const MySignUp2(),
    ),
  
  ];
}
