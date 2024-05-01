import 'package:chitchat/screen/home_pages.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../theme/constants.dart';
import 'signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAdminController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();

  bool _passwordVisible = false;
  bool _passwordAdminVisible = false;
  bool satusSignUp = false;
  GlobalKey<FormState> formkeySignUp = GlobalKey<FormState>();
  List<String> role = [
    'Student',
    'Admin',
  ];
  final controller = Get.put(AuthController());
  String? selectedRole = 'Student';
  String password = "isiadmin";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Center(
              child: Image.asset(
            "assets/logo_title_image.png",
            height: 60,
          )),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Form(
            key: formkeySignUp,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sign up",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          "assets/signup_image.png",
                          height: 230,
                        ),
                        SizedBox(height: 10),
                        DropdownButton<String>(
                          value: selectedRole,
                          items: role
                              .map(
                                (item) => DropdownMenuItem<String>(
                                    value: item, child: Text(item)),
                              )
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectedRole = item;
                          }),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _fullnameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Enter FullName",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "*Required"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Enter your e-mail address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.alternate_email_outlined),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "*Required"),
                              EmailValidator(
                                  errorText:
                                      "Please enter a valid e-mail address"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          maxLines: 1,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.lock_person_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "*Required"),
                            MinLengthValidator(6,
                                errorText:
                                    "Password must contain at least 6 characters"),
                            MaxLengthValidator(15,
                                errorText:
                                    "The password must not contain more than 15 characters.")
                          ]),
                        ),
                        SizedBox(height: 10),
                        selectedRole == "Admin"
                            ? TextFormField(
                                controller: _passwordAdminController,
                                maxLines: 1,
                                obscureText: !_passwordAdminVisible,
                                decoration: InputDecoration(
                                  hintText: "Enter admin password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon: Icon(Icons.lock_person_outlined),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordAdminVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordAdminVisible =
                                            !_passwordAdminVisible;
                                      });
                                    },
                                  ),
                                ),
                                style: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle,
                                validator: (value) {
                                  if (value != password) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                })
                            : Container(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: kBlueColor,
                      ),
                      onPressed: () async {
                        if (formkeySignUp.currentState!.validate()) {
                          final usr = UserModel(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            fullName: _fullnameController.text.trim(),
                            role: selectedRole,
                          );
                          satusSignUp =
                              (await controller.createUserController(usr))!;
                          if (satusSignUp) {
                            UserModel usr = (await controller
                                .getUserDetailsController(selectedRole!))!;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePages(usr: usr),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Something wrong")));
                          }
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SigninPage(),
                      ),
                    );
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline5!,
                      children: <TextSpan>[
                        TextSpan(
                          text: "I have an account?  ",
                        ),
                        TextSpan(
                          text: "sign in here ",
                          style: TextStyle(
                              color: kBlueColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
