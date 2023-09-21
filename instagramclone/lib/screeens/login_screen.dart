import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/util/colors.dart';
import 'package:instagramclone/widgets/text_feild_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passWordController = TextEditingController();

    @override
    void dispose() {
      super.dispose();
      _emailController.dispose();
      _passWordController.dispose();
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 1),
              SvgPicture.asset(
                'assets/instagram.svg',
                height: 65,
                color: Colors.white,
              ),
              const SizedBox(height: 65),
              TextFeildInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email here',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 25),
              TextFeildInput(
                textEditingController: _passWordController,
                hintText: 'Enter your password here',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 25),
              // InkWell(
              //   onTap: (){},
              //   child: Container(
              //     child: const Text('Log in'),
              //     width: double.infinity,
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(vertical: 12),
              //     decoration: const ShapeDecoration(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.all(Radiusdart:ffi.circular(4))),
              //         color: blueColor),
              //   ),
              // ),
              ElevatedButton(onPressed: (){}, child: Container(
                child: Text('Login'),
                width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        color: blueColor),
                  ),
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have a account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
