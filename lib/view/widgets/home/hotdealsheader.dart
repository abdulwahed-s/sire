import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class HotDealsHeader extends StatelessWidget {
  const HotDealsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Appcolor.amaranthpink, Appcolor.berry],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF667eea).withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_fire_department,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: 8),
              Expanded(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'HOT DEALS & OFFERS',
                      textStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Sw",
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  pause: Duration(seconds: 3),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Limited time offers - Don\'t miss out!',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontFamily: "Sw",
            ),
          ),
        ],
      ),
    );
  }
}

