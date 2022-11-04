import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccauntClass extends StatefulWidget {
  const MyAccauntClass({super.key});

  @override
  State<MyAccauntClass> createState() => _MyAccauntClassState();
}

class _MyAccauntClassState extends State<MyAccauntClass> {
  bool _isObscures = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passowordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void initState() {
    getName();
    super.initState();
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString("Name") ?? "";
    emailController.text = prefs.getString("Email") ?? "";
    phoneController.text = prefs.getString("Phone") ?? "";
    passowordController.text = prefs.getString("Passoword") ?? "";
    confirmController.text = prefs.getString("Confim") ?? "";
  }

  Future<bool> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("Name", nameController.text);
    prefs.setString("Email", emailController.text);
    prefs.setString("Phone", phoneController.text);
    prefs.setString("Passoword", passowordController.text);
    prefs.setString("Confim", confirmController.text);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 15),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 160,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Let's Get Started!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Create an account to Q Allure to get all features",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  _textFromField1(
                      "Name", Icons.perm_identity, nameController, true),
                  const SizedBox(height: 14),
                  _textFromField1(
                      "Email", Icons.email_outlined, emailController, true),
                  const SizedBox(height: 14),
                  _textFromField1(
                      "Phone", Icons.phone_android, phoneController, true),
                  const SizedBox(height: 14),
                  _textFromField1(
                      "Passoword", Icons.lock_open, passowordController, false),
                  const SizedBox(height: 14),
                  _textFromField1("Confirm Passoword", Icons.lock_open,
                      confirmController, false),
                  const SizedBox(height: 36),
                  ElevatedButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.leftSlide,
                        headerAnimationLoop: false,
                        dialogType: DialogType.info,
                        showCloseIcon: true,
                        title: 'Save',
                        desc:
                            'Name, Email, Phone, Passoword, Confirm Passoword',
                        btnCancelOnPress: () {
                          _flutterToast("Email, Passoword,No Saved", false);
                        },
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                          _flutterToast("Email, Passoword, Saved", true);
                          _saveName();
                        },
                        btnOkIcon: Icons.check_circle,
                        onDismissCallback: (type) {
                          debugPrint('Dialog Dissmiss from callback $type');
                        },
                      ).show();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      fixedSize: const Size(170, 50),
                      backgroundColor: const Color.fromARGB(255, 21, 81, 207),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      "CREATE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 58),
                  RichText(
                    text: TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        children: const [
                          TextSpan(
                            text: " Login here",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _textFromField1(String s, IconData lock_open,
      TextEditingController controller, bool lokol) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: controller,
        obscureText: lokol ? false : _isObscures,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: s,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          prefixIcon: lokol
              ? Icon(lock_open)
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscures = !_isObscures;
                    });
                  },
                  icon: Icon(_isObscures ? Icons.lock_outline : lock_open),
                ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
    );
  }

  void _flutterToast(String s, bool isColor) {
    Fluttertoast.showToast(
      msg: s,
      backgroundColor: isColor ? Colors.green : Colors.red,
      fontSize: 20,
      timeInSecForIosWeb: 12,
    );
  }
}
