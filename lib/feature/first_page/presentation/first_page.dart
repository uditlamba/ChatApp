import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mobility_login/feature/auth/presentation/data/login.dart';
import '../../../core/common/color.dart';
import '../../auth_with_email/presentation/login.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: const Text("Please Select One",style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: ColorConst.blueAcc100,
      ) ,
      body:   Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(  'assets/images/login.jpg',),
              const Gap(40),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Get.to(()=>const LoginPage());
                  },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorConst.blueAcc100),
                        foregroundColor: MaterialStateProperty.all(ColorConst.black87),
                      ),
                      child: const Text("Login With Mobile No",style: TextStyle(fontSize: 25),))),
              const Gap(50),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Get.to(()=> const LoginWithEmail());
                  },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorConst.blueAcc100),
                        foregroundColor: MaterialStateProperty.all(ColorConst.black87),
                      ),
                      child: const Text("Login With Email",style: TextStyle(fontSize: 25),))),
            ],
          ),
        ),
      ),
    );
  }
}
