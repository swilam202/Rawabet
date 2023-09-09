import 'package:chatapp/pages/login%20page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: AspectRatio(
              aspectRatio: 1 / 2,
              child: Image.asset(
                'assets/chatapp.png',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.elasticIn,
    );
    animationController
        .forward()
        .then((_) => animationController.reverse())
        .then((_) => navigateToAuth());
  }

  void navigateToAuth() {
    Navigator.of(context).pushReplacementNamed('login');
  }
}
