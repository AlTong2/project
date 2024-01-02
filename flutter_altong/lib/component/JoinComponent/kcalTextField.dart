import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KcalTextField extends StatelessWidget {
  const KcalTextField({super.key, required this.icon, required this.text, required this.con});
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
        suffixText: "Kcal",
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ]
    );
  }
}
