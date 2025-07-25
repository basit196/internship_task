import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_task/Resources/Widgets/CustomText.dart';
import 'package:internship_task/Resources/utils/Appcolors.dart';

class Wellcome extends StatefulWidget {
  const Wellcome({super.key});

  @override
  State<Wellcome> createState() => _WellcomeState();
}

class _WellcomeState extends State<Wellcome> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolors.yellow,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mediaQuery.height * 0.06),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Good ',
                      style: TextStyle(
                        color: Appcolors.Black,
                        fontSize: 70.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' Food',
                      style: TextStyle(
                        color: Appcolors.White,
                        fontSize: 70.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Great ',
                      style: TextStyle(
                        color: Appcolors.White,
                        fontSize: 70.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' Life',
                      style: TextStyle(
                        color: Appcolors.Black,
                        fontSize: 70.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.04),

              Center(
                child: CircleAvatar(
                  backgroundColor: Appcolors.Darkyellow,
                  radius: 200,
                  backgroundImage: AssetImage("assets/image 10.png"),
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: mediaQuery.height * 0.06,
                    width: mediaQuery.width * 0.4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        GoRouter.of(context).goNamed("Login");
                      },
                      child: CustomText(
                        text: "Get Start",
                        color: Appcolors.White,
                        fontWeight: FontWeight.w500,
                        fontSize: 22.sp,
                      ),
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
