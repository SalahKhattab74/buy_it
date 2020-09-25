import 'package:buy_it/provider/modelHud.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/user/home_page.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/user/loginScreen.dart';
import 'package:buy_it/widgets/custom_text_field.dart';
import 'package:buy_it/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/auth.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              iconWidget(),
              SizedBox(
                height: height * 0.1,
              ),
              custom_text_field(
                onClick: (value) {},
                hint: 'Enter Your Name',
                icon: Icons.perm_identity,
              ),
              SizedBox(
                height: height * 0.02,
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
                      onPressed: () async {
                        final modelhud =
                            Provider.of<ModelHud>(context, listen: false);
                        modelhud.changeIsLoading(true);
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          try {
                            final authResult =
                                await _auth.signUp(_email, _password);
                            modelhud.changeIsLoading(false);
                            Navigator.pushNamed(context, HomePage.id);
                          } catch (e) {
                            modelhud.changeIsLoading(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text(e.message)));
                          }
                        }
                        modelhud.changeIsLoading(false);
                      },
                      child: Text(
                        'SignUp',
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
                    "Do Have An Account?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text('Login', style: TextStyle(fontSize: 16))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
