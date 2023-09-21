import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/resources/auth.dart';
import 'package:instagramclone/util/utils.dart';

import '../util/colors.dart';
import '../widgets/text_feild_input.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passWordController = TextEditingController();
    final TextEditingController _bioController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    Uint8List? _profileImage;

    @override
    void dispose() {
      super.dispose();
      _emailController.dispose();
      _passWordController.dispose();
      _bioController.dispose();
      _usernameController.dispose();
    }

    void selectImage() async {
      Uint8List profileimage = await pickImage(ImageSource.gallery);
      setState(() {
        _profileImage = profileimage;
      });
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
                color: primaryColor,
              ),
              Flexible(child: Container(), flex: 1),
              Stack(
                children: [
                  _profileImage != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_profileImage!),
                        )
                      : const CircleAvatar(
                          radius: 65,
                          child: Icon(
                            Icons.person,
                            size: 120,
                          ),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(Icons.add_a_photo),
                      ))
                ],
              ),
              Flexible(child: Container(), flex: 1),
              TextFeildInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter your username here',
                  textInputType: TextInputType.text),
              const SizedBox(height: 10),
              TextFeildInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email here',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              TextFeildInput(
                textEditingController: _passWordController,
                hintText: 'Enter your password here',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 10),
              TextFeildInput(
                  textEditingController: _bioController,
                  hintText: 'Enter your bio here',
                  textInputType: TextInputType.text),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  String res = AuthMethods().signIn(
                      email: _emailController.text,
                      password: _passWordController.text,
                      username: _usernameController.text,
                      bio: _bioController.text) as String;
                  print(res);
                },
                child: Container(
                  child: const Text('Sign in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       child: const Text("Don't have a account?"),
              //       padding: const EdgeInsets.symmetric(vertical: 8),
              //     ),
              //     GestureDetector(
              //       onTap: (){},
              //       child: Container(
              //         child: const Text(
              //           "Sign up",
              //           style: TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //         padding: const EdgeInsets.symmetric(vertical: 8),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
