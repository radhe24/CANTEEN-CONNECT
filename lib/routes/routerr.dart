// ignore_for_file: unused_local_variable
import "package:clickncollect/loader/loader.dart";
import "package:clickncollect/presentation/payment/accept_screen.dart";
import "package:clickncollect/presentation/payment/payment_screen.dart";
import "package:clickncollect/presentation/Menu/menu_screen.dart";
import "package:clickncollect/presentation/cart/cart_screen.dart";
import "package:clickncollect/presentation/home_screen/home_screen.dart";
import "package:clickncollect/presentation/login/login_screen.dart";
import "package:clickncollect/presentation/password_reset/pass_reset_screen.dart";

import "package:clickncollect/presentation/signup/signup_screen.dart";
import "package:flutter/material.dart";


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments.toString();
    

    switch (settings.name){
      case '/loader':
      return MaterialPageRoute(builder: (_) => const Loader());
      case '/':
      return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
      return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/home':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/pass_reset':
      return MaterialPageRoute(builder: (_) => const PassResetScreen());
      case '/menu':
      return MaterialPageRoute(builder: (_) =>  MenuScreen(args));
      case '/cart':
      return MaterialPageRoute(builder: (_) =>  const CartScreen());
      case '/chkout':
      return MaterialPageRoute(builder: (_) =>  const PaymentScreen());
      case '/accept':
      return MaterialPageRoute(builder: (_) =>  const AcceptScreen());
      default:
      return error();
    }
  }

  static Route<dynamic> error(){
    return MaterialPageRoute(builder: (_){
    return const Scaffold(
      body: Center(child : Text("Error")),
    );});
  }
}