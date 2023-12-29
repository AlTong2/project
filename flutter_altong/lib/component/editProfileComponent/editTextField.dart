import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({super.key, required this.icon, required this.text, required this.con});
  final IconData icon;
  final String text;
  final TextEditingController con;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: con,
      decoration: InputDecoration(
        label: Row(
          children: [
            Icon(icon),
            Text(text)
          ],
        ),
      ),
    );;
  }
}
