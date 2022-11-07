import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:modul6_task3/images/app_icons.dart';
import 'package:modul6_task3/images/app_images.dart';
import 'package:modul6_task3/routes/app_rountes.dart';

class MySignIn1 extends StatefulWidget {
  const MySignIn1({super.key});

  @override
  State<MySignIn1> createState() => _MySignIn1State();
}

class _MySignIn1State extends State<MySignIn1> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    getEmailPassword();
    super.initState();
  }

  void getEmailPassword() async {
    final box = await Hive.openBox("kod");
    _emailController.text = box.get("email");
    _passwordController.text = box.get("password");
  }

  Future<bool> _saveEmailPassword() async {
    final box = await Hive.openBox("kod");
    box.put("email", _emailController.text);
    box.put("password", _passwordController.text);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: const Color.fromARGB(255, 7, 127, 123),
              padding: const EdgeInsets.only(left: 10, top: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(AppImages.vectorImag),
                        ),
                        const SizedBox(height: 24),
                        _text("Welcome", true),
                        const SizedBox(height: 4),
                        _text("Sign In", false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.only(left: 30, right: 30, top: 55),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text("Email", true),
                    _textfiel("Email", true, _emailController),
                    const SizedBox(height: 24),
                    _text("Password", true),
                    _textfiel("Enter Password", false, _passwordController),
                    const SizedBox(height: 48),
                    _textGrey("Forget Password?"),
                    const SizedBox(height: 30),
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
                            Get.toNamed(AppRoutes.signup2);
                          },
                          btnOkOnPress: () {
                            _flutterToast("Email, Passoword, Saved", true);
                            Get.toNamed(AppRoutes.signup2);
                            _saveEmailPassword();
                          },
                          btnOkIcon: Icons.check_circle,
                        ).show();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: const Size(double.maxFinite, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 7, 127, 123)),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            endIndent: 16,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        _textGrey("OR"),
                        const Expanded(
                          child: Divider(
                            indent: 16,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.facebok),
                        const SizedBox(width: 30),
                        SvgPicture.asset(AppIcons.vector),
                        const SizedBox(width: 30),
                        SvgPicture.asset(AppIcons.google),
                      ],
                    ),
                    const SizedBox(height: 52),
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          children: [
                            TextSpan(
                              text: " SignUp",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 7, 127, 123),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _text(String s, bool size) {
    return Text(
      s,
      style: TextStyle(
        color: size ? const Color.fromARGB(255, 13, 73, 71) : Colors.white,
        fontSize: size ? 16 : 28,
        fontWeight: size ? FontWeight.w500 : FontWeight.w500,
      ),
    );
  }

  _textfiel(String text, bool valiDator, TextEditingController controller) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (valiDator) {
            if (value?.contains("@") == false) {
              return "Error";
            }
            // Fluttertoast.showToast(
            //   msg: "Error: @",
            //   gravity: ToastGravity.TOP,
            //   timeInSecForIosWeb: 4,
            //   toastLength: Toast.LENGTH_LONG,
            // );
          }
        },
        decoration: InputDecoration(
          // labelText: text,
          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }

  _textGrey(String s) {
    return Center(
      child: Text(
        s,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
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
