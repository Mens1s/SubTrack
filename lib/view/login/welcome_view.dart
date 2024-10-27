import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/common_widget/primary_button.dart';
import 'package:trackizer/view/main_tab/main_tab_view.dart';
import '../../common/color_extension.dart';
import 'package:trackizer/generated//l10n.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Image.asset(
          "assets/img/welcome_screen.png",
          width: media.width,
          height: media.height,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/img/app_logo.png",
                    width: media.width * 0.5, fit: BoxFit.contain),
                const Spacer(),
                Text(
                  S.of(context).welcome_screen_message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: TColor.white, fontSize: 14),
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  title: S.of(context).lets_start,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainTabView()));
                  },
                  fontSize: 16,
                ),
                const SizedBox(
                  height: 15,
                ),

              ],
            ),
          ),
        )
      ]),
    );
  }
}
