import 'package:flutter/material.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );

Widget defaultFromField({
  required TextEditingController controller,
  required String Label,
  required IconData prefix,
  required String? Function(String?)? validate,
  bool? isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  TextInputType? Type,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword!,
      validator: validate,
      keyboardType: Type,
      decoration: InputDecoration(
        labelText: Label,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({
  required String text,
  required void Function()? function,
}) =>
    TextButton(onPressed: function, child: Text(text));

Widget defaultButton({
  double radius = 3.0,
  Color background = Colors.purple,
  double width = double.infinity,
  required void Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
