// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class SignUpPage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<SignUpPage> {
  bool isAlrUser = false;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        print('User signed in: $account');
        setState(() {
          isAlrUser = true;
        });
      } else {
        setState(() {
          isAlrUser = false;
        });
      }
    });
  }

  login() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user?.displayName);
  }

  Widget buildAuthScreen() {
    return Text('Authenticated');
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      backgroundColor: const Color(0xff0f0c0c),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 41.0, end: 41.0),
            Pin(size: 134.0, middle: 0.3141),
            child: Text(
              'Welcome to\nJukeBoxd ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 50,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 100.0, middle: 0.469),
            Pin(size: 100.0, start: 123.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/HomePageLogo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 43.6, end: 43.6),
            Pin(size: 1.0, middle: 0.4602),
            child: SvgPicture.string(
              '<svg viewBox="43.6 388.0 302.7 1.0" ><path transform="translate(-412.35, -288.0)" d="M 456 675.9639282226562 L 758.7090454101562 675.9639282226562" fill="none" stroke="#9123bf" stroke-width="7" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 120.0, start: 41.0),
            Pin(size: 44.0, middle: 0.5238),
            child: Text(
              'Log In',
              style: TextStyle(
                fontFamily: 'Bahnschrift',
                fontSize: 25,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 98.0, start: 41.0),
            Pin(size: 46.0, middle: 0.614),
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Bahnschrift',
                fontSize: 25,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: login,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 400, left: 275),
                    child: Container(
                      //padding: EdgeInsets.fromLTRB(10, 100, 100, 10),
                      width: 64.0,
                      height: 64.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/loginIconHP.png'),
                        fit: BoxFit.fitWidth,
                      )),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAlrUser ? buildAuthScreen() : buildUnAuthScreen();
  }
}
