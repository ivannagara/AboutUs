import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CardGameController extends GetxController {
  // Card content and state
  final RxList<String> cardQuestions = <String>[].obs;
  final RxInt currentCardIndex = 0.obs;
  final RxBool isCardDrawn = false.obs;
  final RxBool isBackgroundBlurred = false.obs;
  final RxBool isCardFlipped = false.obs;
  
  // Animation controllers
  late AnimationController cardDrawAnimationController;
  late AnimationController cardFlipAnimationController;
  
  @override
  void onInit() {
    super.onInit();
    // Initialize with sample card questions
    cardQuestions.value = [
      "What's your favorite childhood memory?",
      "What's one thing you wish more people knew about you?",
      "If you could master any skill instantly, what would it be?",
      "What was the most impactful book or movie you've experienced?",
      "What's your definition of success?",
      "If you could have dinner with anyone (dead or alive), who would it be?",
      "What do you think is your best personality trait?",
      "What's a personal belief you hold that others might disagree with?",
      "What's one goal you'd like to accomplish in the next year?",
      "What's something you learned about yourself recently?",
      "What are you most grateful for in life?",
      "What advice would you give to your younger self?",
      "What's something that makes you unique?",
      "What are you most afraid of?",
      "What makes you feel truly alive?",
      "What's something you've always wanted to try but haven't yet?",
      "What's a challenge you've overcome that you're proud of?",
      "What's a perfect day for you?",
      "Who has influenced you the most in life?",
      "What's something not many people know about you?",
      "What's your most treasured possession and why?",
      "What's a mistake you've made that taught you something important?",
      "What's something you wish you were better at?",
      "What's the most beautiful place you've ever been?",
      "If you could change one thing about the world, what would it be?",
    ];
    
    // Shuffle the cards initially
    cardQuestions.shuffle();
  }

  // Set up animation controllers - called after context is available
  void setupAnimationControllers(TickerProvider vsync) {
    cardDrawAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 500),
    );
    
    cardFlipAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );
  }
  
  // Dispose animation controllers
  @override
  void onClose() {
    cardDrawAnimationController.dispose();
    cardFlipAnimationController.dispose();
    super.onClose();
  }
  
  // Draw a card from the deck
  void drawCard() {
    if (isCardDrawn.value) return; // Prevent drawing while a card is already shown
    
    isCardDrawn.value = true;
    
    // Start the card draw animation
    cardDrawAnimationController.forward(from: 0.0).then((_) {
      // Apply blur after card is drawn
      isBackgroundBlurred.value = true;
      
      // Start the flip animation
      cardFlipAnimationController.forward(from: 0.0).then((_) {
        isCardFlipped.value = true;
      });
    });
  }
  
  // Go to next card
  void nextCard() {
    // Reset the animations and state
    isCardFlipped.value = false;
    isBackgroundBlurred.value = false;
    isCardDrawn.value = false;
    cardDrawAnimationController.reset();
    cardFlipAnimationController.reset();
    
    // Increment the card index (with looping)
    currentCardIndex.value = (currentCardIndex.value + 1) % cardQuestions.length;
  }
  
  // Get current card text
  String getCurrentCardText() {
    if (cardQuestions.isEmpty) return "No cards available";
    return cardQuestions[currentCardIndex.value];
  }
}