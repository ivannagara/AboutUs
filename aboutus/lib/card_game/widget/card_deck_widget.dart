import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDeck extends StatelessWidget {
  final VoidCallback onTap;
  final int numberOfCards;
  
  const CardDeck({
    super.key,
    required this.onTap,
    this.numberOfCards = 5,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Stack of multiple card backs to represent the deck
          for (int i = 0; i < numberOfCards; i++)
            Positioned(
              top: i * 2.0, // Slight offset for each card
              child: _buildCardBack(i == numberOfCards - 1),
            ),
            
          // Tap instruction
          Positioned(
            bottom: -50,
            child: Text(
              'tapDeck'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Build a single card back
  Widget _buildCardBack(bool isTopCard) {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        color: isTopCard ? Colors.indigo.shade800 : Colors.indigo.shade900,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isTopCard ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ] : null,
        border: Border.all(
          color: Colors.indigo.shade300,
          width: 2,
        ),
      ),
      child: isTopCard ? Center(
        child: Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.indigo.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.help_outline,
            size: 40,
            color: Colors.indigo.shade300,
          ),
        ),
      ) : null,
    );
  }
}