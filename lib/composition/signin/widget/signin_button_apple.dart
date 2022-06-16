import 'package:flutter/material.dart';

class SignInButtonApple extends StatelessWidget {
  final void Function()? onTap;

  const SignInButtonApple({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.black,
        ),
        child: Stack(
          children: const [
            SizedBox(
              width: 48.0,
              height: 48.0,
              child: Icon(
                Icons.apple,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            Center(
              child: Text(
                "Apple로 로그인",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
