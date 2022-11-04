import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:modul6_task3/images/app_icons.dart';
import 'package:modul6_task3/images/app_images.dart';
import 'package:modul6_task3/routes/app_rountes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUserAccount extends StatefulWidget {
  const MyUserAccount({super.key});

  @override
  State<MyUserAccount> createState() => _MyUserAccountState();
}

class _MyUserAccountState extends State<MyUserAccount> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final box = await Hive.openBox("Login");
    emailController.text = box.get("Email") ?? "";
    passwordController.text = box.get("Password") ?? "";
  }

  Future<bool> _saveData() async {
    final box = await Hive.openBox("Login");
    box.put("Email", emailController.text);
    box.put("Password", passwordController.text);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 12, 55, 90),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, right: 30, left: 30),
              child: Image.asset(
                AppImages.account,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Sign in to continuo",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 26),
              child: Column(
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      // validator: (value) {
                      //   if (value?.contains("@") == false) {
                      //     return "Error";
                      //   }
                      // },
                      controller: emailController,
                      decoration: const InputDecoration(
                        // hoverColor: Colors.red,
                        fillColor: Colors.transparent,
                        focusColor: Colors.red,
                        hintText: "User Name",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          size: 24,
                          color: Colors.grey,
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(28),
                        //   borderSide: const BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      obscureText: isObscure,
                      controller: passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        hintText: "Password",
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(
                            isObscure
                                ? (Icons.visibility_off_outlined)
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(
                            isObscure ? Icons.lock : Icons.lock_open,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.question,
                            showCloseIcon: true,
                            title: 'Clear',
                            desc: 'User Name, Passoword',
                            btnOkOnPress: () {
                              _flutterToast(
                                  "User Name, Passoword, Clear", false);
                            },
                            btnOkIcon: Icons.check_circle,
                            btnOkColor: Colors.red,
                          ).show();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Clear: User Name,Paassword",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.info,
                            showCloseIcon: true,
                            title: 'Save',
                            desc: 'User Name, Passoword',
                            btnCancelOnPress: () {
                              _flutterToast(
                                  "User Name, Passoword,No Saved", false);
                            },
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                              _flutterToast(
                                  "User Name, Passoword, Saved", true);
                              _saveData();
                            },
                            btnOkIcon: Icons.check_circle,
                            onDismissCallback: (type) {
                              debugPrint('Dialog Dissmiss from callback $type');
                            },
                          ).show();
                        },
                        child: const Text(
                          "Save Password?",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.userAccaunt2);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: const Color.fromARGB(255, 72, 108, 207),
                        fixedSize: const Size(80, 80),
                        backgroundColor:
                            const Color.fromARGB(255, 72, 108, 207),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 36,
                      )),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("SIGN UP",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(String s, IconData facebook, bool c) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor:
            c ? const Color.fromARGB(255, 81, 114, 203) : Colors.red,
      ),
      icon: Icon(facebook),
      label: Text(
        s,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  void _flutterToast(String text, bool isColor) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: isColor ? Colors.green : Colors.red,
      fontSize: 20,
      timeInSecForIosWeb: 12,
    );
  }
}
