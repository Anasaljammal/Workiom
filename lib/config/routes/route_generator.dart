import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/signin_page.dart';
import '../../features/auth/presentation/pages/enter_password_page.dart';
import '../../features/auth/presentation/pages/company_info_page.dart';
import '../../features/auth/presentation/pages/thank_you_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case AppRoutes.enterPassword:
        return MaterialPageRoute(builder: (_) => const EnterPasswordPage());

      case AppRoutes.companyInfo:
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (_) => CompanyInfoPage(
            email: args?['email'] ?? '',
            password: args?['password'] ?? '',
          ),
        );

      case AppRoutes.thankYou:
        return MaterialPageRoute(builder: (_) => const ThankYouPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
