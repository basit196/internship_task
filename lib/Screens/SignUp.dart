import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_task/Proivders/AuthProivder.dart';
import 'package:internship_task/Resources/Widgets/CustomText.dart';
import 'package:internship_task/Resources/Widgets/CutomField.dart';
import 'package:internship_task/Resources/utils/Appcolors.dart';

class SignUp extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final signUpState = ref.watch(signUpControllerProvider);
    final signUpController = ref.read(signUpControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: mediaQuery.height * 0.06),
                  CustomText(
                    text: "Create Account",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: mediaQuery.height * 0.06),

                  if (signUpState.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        signUpState.error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  /// Name Field
                  CustomTextField(
                    controller: nameController,
                 
                    label: "Name",
                    icon: Icons.person,
                    validator: _validateName,
                  ),
                  SizedBox(height: mediaQuery.height * 0.03),

                  /// Email Field
                  CustomTextField(
                    controller: emailController,
                  
                    label: "Email",
                    icon: Icons.email,
                    validator: _validateEmail,
                  ),
                  SizedBox(height: mediaQuery.height * 0.03),

                  /// Password Field
                  CustomTextField(
                    controller: passwordController,
                    
                    label: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  SizedBox(height: mediaQuery.height * 0.03),

                  /// Confirm Password Field
                  CustomTextField(
                    controller: confirmPasswordController,
                  
                    label: "Confirm Password",
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: _validateConfirmPassword,
                  ),
                  SizedBox(height: mediaQuery.height * 0.04),

                  /// Sign Up Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: signUpState.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                signUpController.signUp(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  context: context,
                                );
                              }
                            },
                      child: signUpState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : CustomText(
                              text: "Sign Up",
                              color: Appcolors.White,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                    ),
                  ),
                  SizedBox(height: 20),

                  /// Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                        child: CustomText(
                          text: "Login",
                          fontWeight: FontWeight.w600,
                          color: Appcolors.yellow,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
