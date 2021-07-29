import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
class landingPage extends StatefulWidget {


  @override
  _State createState() => _State();
}

class _State extends State<landingPage> {
final FirebaseAuth _auth = FirebaseAuth.instance;

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }



  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      
      body: Container(
        alignment: Alignment.center,
        child: Column(
          
          children: <Widget>[

            SizedBox(height: 30),
            Container(
              height: 400,
              width: 600,
              child: Image(image: AssetImage("images\\start.jpg"),
              fit: BoxFit.contain,
              ),
              
            ),
            SizedBox(height: 30),

            RichText(
              
              text: TextSpan(
                text: "Welcome to", 
                style: TextStyle(
                  fontSize: 27.0, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                children: <TextSpan>[
                  TextSpan(
                    text: " Diner", 
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900],
                    ) 


                  )

                ]

              ),
            ),
            SizedBox(height: 7),

            Text("Make your meals exciting!",
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 20),


            Column(
              crossAxisAlignment: CrossAxisAlignment.center,


              children: <Widget>[
                
              SizedBox(
                width: 200,
                height: 50,
                child:  ElevatedButton(onPressed: navigateToRegister, 
                style: ElevatedButton.styleFrom(elevation: 10,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),
                    ),
                    primary: Color.fromRGBO(231, 0, 44, 32),
                  ),
                  child: Text('Register'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ),
              ),

              SizedBox(height: 20),




              SizedBox(
                width: 200,
                height: 50,
                child:  ElevatedButton(onPressed: navigateToLogin, 
                style: ElevatedButton.styleFrom(elevation: 10,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),
                    ),
                    primary: Color.fromRGBO(231, 0, 44, 32),
                  ),
                  child: Text('Login'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ),
              ),

              SizedBox(height: 20),

              Text("Forgot your password?",
              style: TextStyle(color: Colors.black),
            ),
            

              ],
            )
          ],
        ),

      ),

    );
    
  }
}