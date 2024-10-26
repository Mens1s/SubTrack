import 'package:flutter/material.dart';
import 'package:trackizer/view/login/sign_up_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/secondary_button.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
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
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/img/apple_btn.png"),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/img/apple.png", width: 20, height: 20,),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Apple ile Kayıt Ol",
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/img/google_btn.png"),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/img/google.png", width: 20, height: 20, color: TColor.gray,),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Google ile Kayıt Ol",
                          style: TextStyle(
                              color: TColor.gray,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/img/fb_btn.png"),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/img/fb.png", width: 20, height: 20),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Facebook ile Kayıt Ol",
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "or",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 25,
              ),
              SecondaryButton(
                title: "E-mail ile kayıt ol",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpView()));
                },
                fontSize: 16,
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Kayıt olarak Kullanma Sözleşmesini Kabul Edeceksiniz. Buraya tıklayarak detalı bilgiye sayhi olabilirsiniz.",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
