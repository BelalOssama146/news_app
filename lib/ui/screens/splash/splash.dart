import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home/home.dart';

class Splash extends StatefulWidget {
  static const String routeName ="splash";
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();

}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),
            (){
      Navigator.pushReplacementNamed(context, Home.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset("assets/splash.png"),
    );
  }
}
