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

class MyUserAccount2 extends StatefulWidget {
  const MyUserAccount2({super.key});

  @override
  State<MyUserAccount2> createState() => _MyUserAccount2State();
}

class _MyUserAccount2State extends State<MyUserAccount2> {
  final _userNameController = TextEditingController();
  final _e_mailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final box = await Hive.openBox("Login");
    _userNameController.text = box.get("userName") ?? "";
    _e_mailController.text = box.get("E-Mail") ?? "";
    _phoneController.text = box.get("phone") ?? "";
    _passwordController.text = box.get("password") ?? "";
  }

  Future<bool> _saveData() async {
    final box = await Hive.openBox("Login");
    box.put("userName", _userNameController.text);
    box.put("E-Mail", _e_mailController.text);
    box.put("phone", _phoneController.text);
    box.put("password", _passwordController.text);

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
            Icons.arrow_back,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 12, 55, 90),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 30, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
              child: Column(
                children: [
                  _textFromField1("User Name", Icons.perm_identity,
                      _userNameController, true),
                  const SizedBox(height: 16),
                  _textFromField1(
                      "E-Mail", Icons.email_outlined, _e_mailController, true),
                  const SizedBox(height: 16),
                  _textFromField1(
                      "Phone Number", Icons.phone, _phoneController, true),
                  const SizedBox(height: 16),
                  _textFromField1("Password", Icons.visibility_outlined,
                      _passwordController, false),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.info,
                          showCloseIcon: true,
                          title: 'Save',
                          desc: 'User Name,E-Mail.................',
                          btnCancelOnPress: () {
                            _flutterToast(
                                "User Name,E-Mail....,No Saved", false);
                          },
                          btnOkOnPress: () {
                            debugPrint('OnClcik');
                            _flutterToast("User Name,E-Mail...., Saved", true);
                            _saveData();
                          },
                          btnOkIcon: Icons.check_circle,
                        ).show();
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
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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

  _textFromField1(String s, IconData lock_open,
      TextEditingController controller, bool lokol) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: controller,
        obscureText: lokol ? false : _isObscure,
        decoration: InputDecoration(
          suffixIconColor: Colors.red,
          fillColor: Colors.transparent,
          filled: true,
          hintText: s,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          prefixIcon: lokol
              ? Icon(
                  lock_open,
                  color: Colors.grey,
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off_outlined : lock_open,
                    color: Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }
}
