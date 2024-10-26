import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:trackizer/view/login/sign_up_view.dart';
import 'package:trackizer/view/login/social_login.dart';

import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/secondary_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray80,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/img/app_logo.png",
                  width: media.width * 0.5, fit: BoxFit.contain),
              const Spacer(),
              RoundTextField(
                title: "Giriş Yap",
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              RoundTextField(
                title: "Password",
                controller: txtPassword,
                obscureText: true,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isRemember = !isRemember;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Icon(isRemember ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded, size: 20, color: TColor.gray50),
                        const SizedBox(width: 5,),
                        Text(
                          "Beni hatırla",
                          style: TextStyle(color: TColor.gray50, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child: Text(
                      "Şifremi unuttum",
                      style: TextStyle(color: TColor.gray50, fontSize: 14),
                    ),
                  ),
                ],

              ),
              const SizedBox(
                height: 5,
              ),
              PrimaryButton(
                title: "Giriş Yap",
                onPressed: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SocialLogin()));*/
                },
                fontSize: 16,
              ),
              const Spacer(),
              Text(
                "Kayıtlı hesabin yok mu?",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              SecondaryButton(
                title: "Kayıt Ol",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()));
                },
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
