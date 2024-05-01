import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../controllers/auth_controller.dart'; // Importer le contrôleur
import '../theme/constants.dart';
import 'signin_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.put(AuthController()); // Obtenir le contrôleur

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Center(
            child: Image.asset(
              "assets/logo_title_image.png",
              height: 60,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  "assets/forgot_password_image.png", // Ajoutez une image appropriée
                  height: 200,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "This field is required"),
                    EmailValidator(errorText: "Enter a valid email"),
                  ]),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: kBlueColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text.trim();

                      // Appeler la fonction de réinitialisation du mot de passe
                      _authController.forgotPasswordController(email);

                      // Afficher un message de confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Email de réinitialisation envoyé")),
                      );
                    }
                  },
                  child: Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SigninPage(),
                      ),
                    );
                  },
                  child: Text(
                    "I have an account? Sign in here",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: kBlueColor,
                          fontWeight: FontWeight.bold,
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
