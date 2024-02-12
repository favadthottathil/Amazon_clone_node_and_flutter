import 'package:amazon_clone_with_nodejs/Common/Widgets/bottom_bar.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Screens/admin_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Auth/Services/auth_service.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Screens/home_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:amazon_clone_with_nodejs/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Scaffold(
        body: Builder(builder: (context) {
          AuthService().getUserData(context: context);

          return Provider.of<UserProvider>(
            context,
          ).user.token.isNotEmpty
              ? Provider.of<UserProvider>(
                        context,
                      ).user.type ==
                      'user'
                  ? const BottomBar()
                  : const AdminScreen()
              : const AuthScreen();
        }),
      ),
    );
  }
}
