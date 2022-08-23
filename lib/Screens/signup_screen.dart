import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Authentication/AuthUser.dart';
import 'package:instagram_clone/Utilities/colors.dart';
import 'package:instagram_clone/Utilities/routes.dart';
import 'package:instagram_clone/Utilities/utils.dart';
import 'package:instagram_clone/Widgets/input_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? img;
  bool isLoading = false;
  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(
      () {
        img = image;
      },
    );
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String email = emailController.text;
    String password = passwordController.text;
    String bio = bioController.text;
    String userName = usernameController.text;

    String result = await AuthUser().userSignUp(
      email: email,
      password: password,
      bio: bio,
      userName: userName,
      image: img!,
    );

    if (result == 'invalid-email') {
      showSnackBar(context, 'The email is invalid');
    } else {
      showSnackBar(context, 'Success');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Filling up empty spaces using FLEXIBLE widget
              // ignore: sort_child_properties_last
              Flexible(child: Container(), flex: 2),

              // Svg immage
              SvgPicture.asset(
                'lib/assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),

              // having some space vertically
              const SizedBox(
                height: 64,
              ),

              // Circular Widget to accept and show our selected file
              Stack(
                children: [
                  img != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(img!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://imgs.search.brave.com/rkGPu7qVPTySzrC0BhrrJvsOhMMi2KFTwDG3JtAM5rM/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly93d3cu/c2FsaXNidXJ5dXQu/Y29tL3dwLWNvbnRl/bnQvdXBsb2Fkcy8y/MDIwLzA5L2F2YXRh/ci0xLXNjYWxlZC5q/cGVn"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                editingController: usernameController,
                hintText: 'Enter Your Username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // TextField input for email
              TextFieldInput(
                editingController: emailController,
                hintText: 'Enter Your Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              // TextField input for password
              TextFieldInput(
                editingController: passwordController,
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              // Textfield input for BIO
              TextFieldInput(
                editingController: bioController,
                hintText: 'Enter Your Bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  signUpUser();
                },
                child: Container(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),

              // Information about not having an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Already have an account ?",
                      style: TextStyle(fontSize: 18),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginScreen,
                        (route) => false,
                      );
                    },
                    child: Container(
                      child: Text(
                        "Login",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
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

  @override
  void dispose() {
    emailController.dispose();
    bioController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
