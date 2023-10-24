import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset( 'assets/images/news-landing-page.png',
            fit: BoxFit.fitWidth,
            // height: height * .5,
          ),
          // SizedBox(height: height * 0.02),
          Text('Stay Informed, Anytime, Anywhere', style: GoogleFonts.anton(letterSpacing: 1,fontSize: 20, color: Colors.blueAccent),),
          // SizedBox(height: height * 0.02),

        ],
      ),
    );
  }
}
