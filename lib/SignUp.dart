import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/HomePage.dart';

/* enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE, //shows registration form
  SHOW_OTP_FORM_STATE, //shows OTP form
}
 */

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password, _phone, _otp;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }
  navigateToHomePage() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }


  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        dynamic user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
            
        if (user != null) {
          await _auth.currentUser.updateDisplayName(_name);
          _auth.signInWithPhoneNumber(_phone);
          navigateToHomePage();
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
  //MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final otpController = TextEditingController();
  final phoneController = TextEditingController();
  String verificationId;
  bool showLoading = false; 
  getMobileFormWidget(context)
  {
   return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Image(
                image: AssetImage("images\\login.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Name';
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (input) => _name = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),

                    Container(
                      child: TextFormField(
                          controller: phoneController,
                          validator: (input) {
                            if (input.length < 11)
                              return 'Provide Minimum 11 digits';
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
              
                          ),
                          obscureText: false,
                          onSaved: (input) => _phone = input),
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 50,
                        child:  ElevatedButton(onPressed: () async{

                          setState(() {
                            showLoading = true;
                          });
                                                  
                          await _auth.verifyPhoneNumber(
                          
                          phoneNumber: phoneController.text, 
                          
                          verificationCompleted: (PhoneAuthCredential) async{
                            Navigator.of(context).pop();
                            SignUp();
                          },
                          verificationFailed: (verificationFailed) async{
                            showError(verificationFailed.message);
                            setState(() {
                             showLoading = false;  
                            });
                          },
                          codeSent: (verificationId, resendingToken) async{

                            showDialog(context: context, 
                            builder: (context) 
                            {
                              return AlertDialog(
                                title: Text(
                                  "Verification Code: ",
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextField(
                                      controller: otpController,
                                    ),
                                  
                                  ],
                                ),
                                actions: <Widget> [
                                  ElevatedButton(
                                    onPressed: () async{
                                      final code = otpController.text.trim();
          
                                      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                                      
                                
                                    }, 
                                    child: Text("Confirm"),
                                     ),
                                ]
                              );
                            }
                            );

                            setState(() {                     
              
                              showLoading = false; 
                            }); 
                          }, 
                          codeAutoRetrievalTimeout: (verificationId) async{
                              _otp = verificationId;
                              showLoading = false; 
                          },
                        );
                        },
                        style: ElevatedButton.styleFrom(elevation: 10,

                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.red),
                                ),

                                  primary: Color.fromRGBO(231, 0, 44, 32),
                                ),
                               child: Text('Send'.toUpperCase(),
                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                         ),
                      ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getMobileFormWidget(context),
    );
  }
}











       
