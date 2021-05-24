import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tnotes_app/provider/GoogleSignIn.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.20),
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: 'WELCOME TO '),
                    TextSpan(
                        text: 'TNOTES',
                        style: TextStyle(
                            color: Color(0xff815FC0),
                            fontSize: 25.5,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Color(0x887D53CC),
                        spreadRadius: 5)
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Color(0xff815FC0),
                  radius: 70.0,
                  child: Icon(
                    Icons.check_sharp,
                    color: Colors.white,
                    size: 100.0,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.18),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 60.0,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: Color(0xff815FC0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextButton.icon(
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.white, size: 35.0,),
                  label: Text(
                    ' Sign in with Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.login();
                  },
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Login to continue...',
                style: TextStyle(fontSize: 16, color: Color(0xff815FC0),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.2,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
