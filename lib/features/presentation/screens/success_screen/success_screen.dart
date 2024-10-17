import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/domain/use_cases/home_use_cases.dart';
import 'package:rj/features/domain/use_cases/order_list_cases.dart';
import 'package:rj/features/domain/use_cases/place_order_cases.dart';
import 'package:rj/features/presentation/screens/main_screen/bloc/main_bloc.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../utils/constants.dart';
import '../home_screen/bloc/home_bloc.dart';

class SuccessScreen extends StatefulWidget {
   SuccessScreen({super.key,required this.paymentId,required this.cartList,required this.priceBreakup,required this.userModel});
  final List<CartModel> cartList;
  final UserProfileModel userModel;
  final Map<String,dynamic> priceBreakup;
  final String paymentId;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _controllerCenter;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    OrderListCases.addOrderDetails(widget.cartList, widget.userModel, widget.priceBreakup,context,widget.paymentId);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animationController.forward();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _animationController.dispose();
     super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degrees to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: PopScope(
        canPop: false,
        child: Stack(
          children: <Widget>[
            //CENTER -- Blast
            _confettiContent(),
            _sucess_content(),
          ],
        ),
      ),
    );
  }

  Align _confettiContent() {
    return Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 5,
              particleDrag: 0.05,
              // apply drag to the confetti
              emissionFrequency: 0.05,
              gravity: 0.05,
              // don't specify a direction, blast randomly
              shouldLoop: true,
              // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              // manually specify the colors to be used
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          );
  }

  Align _sucess_content() {
    return Align(
            alignment: Alignment.center,
            child: //_text("qwert"),
                SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(_animationController),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                  sizedH20,
                  Text(
                    "Payment Success",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
  }
}
