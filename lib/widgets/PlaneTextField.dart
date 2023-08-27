// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:login_system/configurations/AppColors.dart';

class PlaneTextField extends StatelessWidget {
  bool isEnabled;
  bool isPassword;
  bool isEmpty;
  int minLines;
  int maxLines;
  final String placeholder;
  final IconData icon;
  final Function onChange;
  TextEditingController controller = TextEditingController();
  PlaneTextField({
    super.key,
    this.isEnabled = true,
    this.isPassword = false,
    this.isEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
    required this.placeholder,
    required this.controller,
    required this.icon,
    required this.onChange,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        minLines: minLines,
        maxLines: maxLines,
        enabled: isEnabled == true ? true : false,
        obscureText: isPassword == true ? true : false,
        controller: controller,
        onChanged: (value) => onChange(value),
        cursorColor: AppColors.PrimaryColor,
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(
            icon,
            color: isEmpty == true ? Colors.red : AppColors.PrimaryColor,
          ),
          hintText: placeholder,
          contentPadding: const EdgeInsets.all(15),
          filled: true,

          //   isEmpty == true ? Colors.red :
          hoverColor: AppColors.PrimaryColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: isEmpty == true
                    ? Colors.red
                    : Color.fromARGB(255, 0, 0, 0)),
            borderRadius: BorderRadius.circular(7),
          ),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(
          //       width: 1,
          //       color: isEmpty == true
          //           ? Colors.red
          //           : Color.fromARGB(255, 255, 0, 0)),
          //   borderRadius: BorderRadius.circular(7),
          // ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: isEmpty == true ? Colors.red : AppColors.PrimaryColor),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}
