import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/routes/go_router.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        useInheritedMediaQuery: true,
        routeInformationParser: MyAppRouter.router.routeInformationParser,
        routerDelegate: MyAppRouter.router.routerDelegate,
        routeInformationProvider: MyAppRouter.router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
