import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:modul6_task3/images/app_icons.dart';
import 'package:modul6_task3/images/app_images.dart';

class MySignUp2 extends StatefulWidget {
  const MySignUp2({super.key});

  @override
  State<MySignUp2> createState() => _MySignUp2State();
}

class _MySignUp2State extends State<MySignUp2> {
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();
  @override
  void initState() {
    getEmail();
    super.initState();
  }

  void getEmail() async {
    final box = await Hive.openBox("Login");
    _emailController.text = box.get("email");
    _numberController.text = box.get("number");
    _addressController.text = box.get("address");
  }

  Future<bool> _saveLogin() async {
    final box = await Hive.openBox("Login");
    box.put("email", _emailController.text);
    box.put("number", _numberController.text);
    box.put("address", _addressController.text);
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
                    _textfiel("Email", true, 0, _emailController),
                    const SizedBox(height: 24),
                    _text("Number", true),
                    _textfiel("Enter Password", false, 1, _numberController),
                    const SizedBox(height: 24),
                    _text("Address", true),
                    _textfiel("Enter Password", false, 2, _addressController),
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
                          desc: 'Email,Number,Address',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            _flutterToast("Email,Number,Address, Saved", true);
                            _saveLogin();
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
                    const SizedBox(height: 44),
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

  _textfiel(
      String text, bool valiDator, int x, TextEditingController controller) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (valiDator) {
            if (value?.contains("@") == false) {
              return "Error: @";
            }
            // Fluttertoast.showToast(
            //   msg: "Error: @",
            //   gravity: ToastGravity.TOP,
            //   timeInSecForIosWeb: 4,
            //   toastLength: Toast.LENGTH_LONG,
            // );
          } else if (x == 1) {
            if (int.tryParse(value.toString()) == null) {
              return "Error: number";
            }
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
      backgroundColor: isColor ? Color.fromARGB(255, 13, 73, 71) : Colors.red,
      fontSize: 20,
      timeInSecForIosWeb: 12,
    );
  }
}
