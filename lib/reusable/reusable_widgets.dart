import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    //color: Colors.white,
  );
}

RegExp username = new RegExp(r'^.{4,}$');
RegExp password = new RegExp(r'^.{8,}$');
RegExp email = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]");

TextFormField reusableTextFeild(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, String test) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (test == "email") {
        if (value!.isEmpty) return ("Please complete field email.");
        if (!email.hasMatch(value)) return ("Please verify email.");
      } else if (test == "password") {
        if (value!.isEmpty) return ("Please complete field password.");
        if (!password.hasMatch(value))
          return ("Please verify password Min 8 character.");
      } else {
        if (value!.isEmpty) return ("Please complete field username.");
        if (!username.hasMatch(value))
          return ("Please verify username Min 4 character.");
      }

      return null;
    },
    onSaved: (value) {
      controller.text = value!;
    },
    obscureText: isPasswordType,
    enableSuggestions: isPasswordType,
    autocorrect: isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, String title, IconData xx, Color cc, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton.icon(
      onPressed: () {
        onTap();
      },
      icon: Icon(
        xx,
        color: cc,
      ),
      label: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) return Colors.black26;
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Container MyCircle(String name) {
  return Container(
    child: CircleAvatar(
      backgroundColor: Colors.black,
      radius: 50,
      child: Text(
        name,
        style: TextStyle(fontSize: 30, color: Colors.green),
      ),
    ),
  );
}
