import 'package:chitchat/screen/forgot_password.dart';
import 'package:chitchat/screen/home_pages.dart';
import 'package:chitchat/screen/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../theme/constants.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool satusSignIn = false;
  List<String> role = [
    'Student',
    'Admin',
  ];
  final controller = Get.put(AuthController());
  String? selectedRole = 'Student';

  GlobalKey<FormState> formkeySignIn = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // components
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
            // format de l'ecriture
            key: formkeySignIn,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sign in",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          "assets/signin_image.png",
                          height: 250,
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
                          controller:
                              _emailController, //controle de format email
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
                          obscureText:
                              !_passwordVisible, // par defaut passoowrd invisible
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
                            MinLengthValidator(8,
                                errorText:
                                    "Password must contain at least 8 characters"),
                            MaxLengthValidator(16,
                                errorText:
                                    "The password must not contain more than 16 characters."),
                          ]),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Forget password?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // bech nebdaw melota w ntal3oh b 20pixel
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
                        //verification validation de form
                        if (formkeySignIn.currentState!.validate()) {
                          //creation model user
                          final user = UserModel(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                          // appel a la fonction login w nda5elo paramertre w role
                          satusSignIn = (await controller.loginUserController(
                              user, selectedRole!))!;

                          if (satusSignIn) {
                            UserModel usr = (await controller
                                .getUserDetailsController(selectedRole!))!;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePages(usr: usr),
                              ),
                            );
                          } else
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Incorrect email or password")));
                        }
                      },
                      child: Text(
                        "Sign In",
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
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline5!,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Don't have an account?  ",
                        ),
                        TextSpan(
                          text: "sign up here ",
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
