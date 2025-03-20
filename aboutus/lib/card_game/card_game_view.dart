import 'package:aboutus/card_game/card_game_controller.dart';
import 'package:aboutus/card_game/widget/card_deck_widget.dart';
import 'package:aboutus/card_game/widget/question_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

class CardGameView extends StatefulWidget {
  const CardGameView({super.key});

  @override
  State<CardGameView> createState() => _CardGameViewState();
}

class _CardGameViewState extends State<CardGameView> with TickerProviderStateMixin {
  // Get the controller
  final CardGameController controller = Get.find<CardGameController>();
  
  // Animations
  late Animation<double> _cardScaleAnimation;
  late Animation<double> _cardFlipAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Setup animations
    controller.setupAnimationControllers(this);
    
    _cardScaleAnimation = Tween<double>(
      begin: 0.3, 
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller.cardDrawAnimationController,
      curve: Curves.easeOutBack,
    ));
    
    _cardFlipAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller.cardFlipAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade800, Colors.indigo.shade500],
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // App bar with back button
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ),
              
              // Background
              Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: controller.isBackgroundBlurred.value
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.1),
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                    : const SizedBox.shrink(),
              )),
              
              // Card deck (only visible when no card is drawn)
              Obx(() => AnimatedOpacity(
                opacity: controller.isCardDrawn.value ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: CardDeck(
                  onTap: controller.drawCard,
                ),
              )),
              
              // Question card (visible when drawn)
              Obx(() {
                if (controller.isCardDrawn.value) {
                  return QuestionCard(
                    questionText: controller.getCurrentCardText(),
                    flipAnimation: _cardFlipAnimation,
                    scaleAnimation: _cardScaleAnimation,
                    onDismiss: controller.nextCard,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}