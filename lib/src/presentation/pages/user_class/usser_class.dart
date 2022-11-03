import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul6_task3/images/app_icons.dart';
import 'package:modul6_task3/images/app_images.dart';
import 'package:modul6_task3/routes/app_rountes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUserClass extends StatefulWidget {
  const MyUserClass({super.key});

  @override
  State<MyUserClass> createState() => _MyUserClassState();
}

class _MyUserClassState extends State<MyUserClass> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString("Email") ?? "";
    passwordController.text = prefs.getString("Password") ?? "";
  }

  Future<bool> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("Email", emailController.text);
    prefs.setString("Password", passwordController.text);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 30, left: 30),
              child: SvgPicture.asset(
                AppIcons.welcomeBack,
                height: 220,
                width: 220,
                fit: BoxFit.cover,
              ),
            ),
            const Center(
              child: Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Log in to your existant account of Q Allure",
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
                      validator: (value) {
                        if (value?.contains("@") == false) {
                          return "Error";
                        }
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        hintText: "Email",
                        hintStyle: const TextStyle(fontSize: 14),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.perm_identity,
                          size: 24,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
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
                        fillColor: Colors.grey.shade200,
                        hintText: "Password",
                        hintStyle: const TextStyle(fontSize: 14),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(
                            isObscure ? Icons.lock : Icons.lock_open,
                            size: 20,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.userAccountClass);
                      },
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.leftSlide,
                        headerAnimationLoop: false,
                        dialogType: DialogType.info,
                        showCloseIcon: true,
                        title: 'Save',
                        desc: 'Email, Passoword',
                        btnCancelOnPress: () {
                          _flutterToast("Email, Passoword,No Saved", false);
                        },
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                          _flutterToast("Email, Passoword, Saved", true);
                          _saveData();
                        },
                        btnOkIcon: Icons.check_circle,
                        onDismissCallback: (type) {
                          debugPrint('Dialog Dissmiss from callback $type');
                        },
                      ).show();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 72, 108, 207),
                      fixedSize: const Size(170, 50),
                      backgroundColor: const Color.fromARGB(255, 72, 108, 207),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      "LOG IN",
                      style: GoogleFonts.adventPro(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    "Or connect using",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _iconButton("Facebook", Icons.facebook, true),
                      const SizedBox(width: 16),
                      _iconButton("Google", Icons.g_mobiledata, false),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Sign Up",
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
