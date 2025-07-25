import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_task/Resources/Widgets/CustomText.dart';
import 'package:internship_task/Resources/utils/Appcolors.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: mediaQuery.height * 0.06),
              CustomText(
                text: "Login",
                fontSize: 40.sp,
                fontWeight: FontWeight.w600,

                textAlign: TextAlign.center,
              ),
              SizedBox(height: mediaQuery.height * 0.06),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.04),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: CustomText(
                    text: "Forgot Password?",
                    color: Appcolors.yellow,
                  ),
                ),
              ),

              /// Login Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    GoRouter.of(context).pushNamed("HomeScreen");
                  },
                  child: CustomText(
                    text: "Login",
                    color: Appcolors.White,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Don't have an account text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pushNamed("SignUp");
                    },
                    child: CustomText(
                      text: "Create account",
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
    );
  }
}
