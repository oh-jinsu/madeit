import 'package:flutter/material.dart';

class SignInButtonGoogle extends StatelessWidget {
  final void Function()? onTap;

  const SignInButtonGoogle({
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
          color: const Color(0xff4285f4),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 2.0,
              left: 2.0,
              child: SizedBox(
                width: 44.0,
                height: 44.0,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Image.asset(
                        "assets/images/symbol_google.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                "Google로 로그인",
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
