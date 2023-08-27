import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String verify="";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode = TextEditingController();
  var phone="";
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 190,
                height: 190,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Phone Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'We need to register your phone before getting started.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countrycode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '|',
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value){
                          phone=value;
                        },
                        keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Phone')),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{
                      await  FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countrycode.text+phone }',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify=verificationId;
                          Navigator.pushNamed(context, "otp");
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text('Send My OTP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
