import 'package:flutter/material.dart';

class SignInButtonKakao extends StatelessWidget {
  final void Function()? onTap;

  const SignInButtonKakao({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        height: 44.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xfffee500),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: 44.0,
              height: 44.0,
              child: Center(
                child: SizedBox(
                  width: 21.0,
                  height: 21.0,
                  child: Image.asset(
                    "assets/images/symbol_kakao.png",
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                "카카오로 로그인",
                style: TextStyle(
                  color: Colors.black,
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
