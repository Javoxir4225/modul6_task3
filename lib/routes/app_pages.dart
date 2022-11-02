import 'package:get/get.dart';
import 'package:modul6_task3/routes/app_rountes.dart';
import 'package:modul6_task3/src/presentation/pages/user_class/usser_class.dart';

class AppPages {
  static final getPages = [
    GetPage(
      name: AppRoutes.userClass,
      page: () => const UserClass(),
    ),
  ];
}
