import 'package:flutter/material.dart';

class LoginPasswordTextField extends StatefulWidget {
  const LoginPasswordTextField({super.key, required this.icon, required this.text, required this.con, required this.validator});
  final IconData icon;
  final String text;
  final TextEditingController con;
  final FormFieldValidator<String?>? validator;

  @override
  State<LoginPasswordTextField> createState() => _LoginPasswordTextFieldState();
}

class _LoginPasswordTextFieldState extends State<LoginPasswordTextField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: widget.con,
      obscureText: !_passwordVisible,//이것은 텍스트를 동적으로 가리게 할 것이다
      decoration: InputDecoration(
        label: Row(
          children: [
            Icon(widget.icon),
            Text(widget.text, style: TextStyle(fontFamily: 'pre'))
          ],
        ),
        hintText: 'Enter your password',
        // 이것이 핵심 아이디어이다
        suffixIcon: IconButton(
          icon: Icon(
            // passwordVisible 상태에 따라 아이콘을 선택한다
            _passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // 상태를 업데이트한다. 즉, passwordVisible 변수의 상태를 토글한다.
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
