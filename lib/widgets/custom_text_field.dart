import 'package:flutter/material.dart';
import 'package:buy_it/constants.dart';

class custom_text_field extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  String _errorMessage(String str) {
    switch (hint) {
      case 'Enter Your Name':
        return 'Name Is Empty!!';
      case 'Enter Your Email':
        return 'email Is Empty !!';
      case 'Enter Your Password':
        return 'Password is Empty!!';
    }
  }

  custom_text_field({@required this.onClick, this.icon, @required this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          // ignore: missing_return
          if (value.isEmpty) {
            return _errorMessage(hint);
          }
        },
        onSaved: onClick,
        obscureText: hint == 'Enter Your Password' ? true : false,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: kMainColor),
            filled: true,
            fillColor: kSecondColor,
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedErrorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
