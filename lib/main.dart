import 'package:buy_it/provider/adminMode.dart';
import 'package:buy_it/provider/modelHud.dart';
import 'package:buy_it/screens/admin/addProduct.dart';
import 'package:buy_it/screens/admin/editProduct.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/admin/admin_home.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/user/home_page.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/user/signup_screen.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Salah%20Khattab/AndroidStudioProjects/buy_it/lib/screens/user/loginScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          EditProduct.id: (context) => EditProduct(),
        },
      ),
    );
  }
}
