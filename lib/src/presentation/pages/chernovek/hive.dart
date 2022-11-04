import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyChernovek extends StatefulWidget {
  const MyChernovek({super.key});

  @override
  State<MyChernovek> createState() => _MyChernovekState();
}

class _MyChernovekState extends State<MyChernovek> {
  final _emailContr = TextEditingController();

  @override
  void initState() {
    getSave();
    super.initState();
  }
 
  void getSave() async {
    final box = await Hive.openBox("login");
    _emailContr.text = box.get("Email") ?? "";
    // _emailContr.text = pref.clear()??;
  }

  Future<bool> _Save() async {
    final box = await Hive.openBox("login");

    box.put("Email", _emailContr.text);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _emailContr,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // _Delet();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    "Delet",
                  ),
                ),
            const SizedBox(width: 60),
                ElevatedButton(
                  onPressed: () {
                    _Save();
                  },
                  child: const Text(
                    "Save",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
