import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/common/color.dart';
import 'home_page.dart';

class OTPScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;
  final String verificationId;
  final int? resendToken;

  const OTPScreen({
    super.key,
    this.phoneNumber,
    this.countryCode,
    required this.verificationId,
    this.resendToken,
  });

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String enteredOTP = '';

  Future<void> _verifyOTP() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: enteredOTP,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        Get.to(  const HomePage());
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text('Incorrect OTP'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        backgroundColor: ColorConst.blueAcc,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter OTP sent to ${widget.phoneNumber}",style: const TextStyle(
              fontSize: 20,fontWeight: FontWeight.w600
            ),),
            const Gap(20),
            OtpTextField(
              borderWidth: 2,
              numberOfFields: 6,
              borderColor:   ColorConst.black,
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                setState(() {
                  enteredOTP = code;
                });
              },
              onSubmit: (String otp) {
                setState(() {
                  enteredOTP = otp;
                });
              },
            ),
            const Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _verifyOTP,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConst.blueAcc),
                    foregroundColor: MaterialStateProperty.all(ColorConst.white),
                  ),
                  child: const Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
