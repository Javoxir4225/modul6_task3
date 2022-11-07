import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:modul6_task3/images/app_images.dart';
import 'package:modul6_task3/routes/app_rountes.dart';

class MyMinyu extends StatefulWidget {
  const MyMinyu({super.key});

  @override
  State<MyMinyu> createState() => _MyMinyuState();
}

class _MyMinyuState extends State<MyMinyu> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation1;
  late Animation _animation2;
  late Animation _animation3;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );
    _animation1 = Tween(end: -2.0, begin: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
        if (_animationStatus == AnimationStatus.dismissed) {
          _animationController.forward();
        } else if (_animationStatus == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });
    _animation2 = Tween(end: -2.0, begin: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
        if (_animationStatus == AnimationStatus.dismissed) {
          _animationController.forward();
        } else if (_animationStatus == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });
    _animation3 = Tween(end: 2.0, begin: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
        if (_animationStatus == AnimationStatus.dismissed) {
          _animationController.forward();
        } else if (_animationStatus == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                 Expanded(
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(left: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _text1("Home Work!"),
                        const SizedBox(height: 30),
                        _text("1.Sign In", true),
                        const SizedBox(height: 12),
                        _text("2.User & Account", false),
                        const SizedBox(height: 12),
                        _text1("3.User class"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY(
                        3.14 * (_animation2.value),
                      ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.signin1);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 214, 215, 222),
                          image: DecorationImage(
                            image: AssetImage(
                              AppImages.scrin2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY(
                        3.14 * (_animation1.value),
                      ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.userAccaunt);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 40, 121, 255),
                          image: DecorationImage(
                            image: AssetImage(
                              AppImages.scrin1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY(
                        3.14 * (_animation3.value),
                      ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.userClass);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 0, 51, 65),
                          image: DecorationImage(
                            image: AssetImage(
                              AppImages.scrin3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }

  _text(String s, bool iscolor) {
    return Text(
      s,
      style: TextStyle(
        color: iscolor
            ? const Color.fromARGB(255, 7, 127, 123)
            : const Color.fromARGB(255, 40, 121, 255),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  _text1(String s) {
    return Text(
      s,
      style: const TextStyle(
        color: Color.fromARGB(255, 8, 58, 72),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
