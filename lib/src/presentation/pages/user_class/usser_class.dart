import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul6_task3/images/app_icons.dart';
import 'package:modul6_task3/images/app_images.dart';

class UserClass extends StatelessWidget {
  const UserClass({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
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
                    TextField(
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
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        hintText: "Password",
                        hintStyle: const TextStyle(fontSize: 14),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock_open,
                          size: 20,
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
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: const Color.fromARGB(255, 72, 108, 207),
                        fixedSize: const Size(170, 50),
                        backgroundColor:
                            const Color.fromARGB(255, 72, 108, 207),
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
                          child:  const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 14,
                              color: Colors.blue,)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
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
}
