import 'package:buy_it/provider/adminMode.dart';
import 'package:buy_it/provider/modelHud.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/admin/admin_home.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/user/signup_screen.dart';
import 'package:buy_it/widgets/custom_text_field.dart';
import 'package:buy_it/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/constants.dart';
import 'package:buy_it/services/auth.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/user/home_page.dart';
import 'package:provider/provider.dart';
import 'package:buy_it/provider/adminMode.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'LoginScreen';
  String _email, _password;
  final _auth = Auth();
  bool isAdmin = false;
  final AdminPassword = '12345a';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            iconWidget(),
            SizedBox(
              height: height * 0.1,
            ),
            custom_text_field(
              onClick: (value) {
                _email = value;
              },
              hint: 'Enter Your Email',
              icon: Icons.email,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            custom_text_field(
                onClick: (value) {
                  _password = value;
                },
                icon: Icons.lock,
                hint: 'Enter Your Password'),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Builder(
                builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.black,
                    onPressed: () {
                      _validate(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't Have An Account?",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text('SignUp', style: TextStyle(fontSize: 16))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(true);
                    },
                    child: Text(
                      'I am Admin',
                      style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? kMainColor
                              : Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(false);
                    },
                    child: Text(
                      'I am User',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.white
                              : kMainColor),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeIsLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == AdminPassword) {
          try {
            await _auth.signIn(_email, _password);
            modelhud.changeIsLoading(false);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelhud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.blueAccent, content: Text(e.message)));
          }
        } else {
          modelhud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.blueAccent,
              content: Text('Something Wrong!!')));
        }
      } else {
        try {
          await _auth.signIn(_email, _password);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.blueAccent, content: Text(e.message)));
        }
      }
    }
    modelhud.changeIsLoading(false);
  }
}
