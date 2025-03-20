import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  final Animation<double> flipAnimation;
  final Animation<double> scaleAnimation;
  final VoidCallback onDismiss;
  
  const QuestionCard({
    super.key,
    required this.questionText,
    required this.flipAnimation,
    required this.scaleAnimation,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // If the user swipes left or right with enough velocity
        if (details.primaryVelocity != null && 
            (details.primaryVelocity! > 300 || details.primaryVelocity! < -300)) {
          onDismiss();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([flipAnimation, scaleAnimation]),
        builder: (context, child) {
          final double flip = flipAnimation.value;
          final double scale = scaleAnimation.value;
          
          // Card face shows when flipAnimation is > 0.5
          final bool showFront = flip >= 0.5;
          
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective effect
              ..rotateY(showFront ? 0 : 3.14159) // No rotation when showing front, 180° (pi) when showing back
              ..scale(scale), // Apply scale animation
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: showFront ? Colors.white : Colors.indigo.shade800,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(
                  color: Colors.indigo.shade300,
                  width: 4,
                ),
              ),
              child: showFront 
                ? _buildCardFront()
                : _buildCardBack(),
            ),
          );
        },
      ),
    );
  }
  
  // Build the front of the card (question side)
  Widget _buildCardFront() {
    return Stack(
      children: [
        // Card content
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              questionText,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        
        // Swipe instruction
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'swipeCard'.tr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.indigo.shade400,
              ),
            ),
          ),
        ),
        
        // Decorative corners
        ..._buildCornerDecorations(),
      ],
    );
  }
  
  // Build the back of the card
  Widget _buildCardBack() {
    return Center(
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.indigo.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.help_outline,
          size: 50,
          color: Colors.indigo.shade300,
        ),
      ),
    );
  }
  
  // Decorative corners for the front of the card
  List<Widget> _buildCornerDecorations() {
    return [
      // Top-left corner
      Positioned(
        top: 10,
        left: 10,
        child: _buildCornerDecoration(),
      ),
      // Top-right corner
      Positioned(
        top: 10,
        right: 10,
        child: _buildCornerDecoration(),
      ),
      // Bottom-left corner
      Positioned(
        bottom: 10,
        left: 10,
        child: _buildCornerDecoration(),
      ),
      // Bottom-right corner
      Positioned(
        bottom: 10,
        right: 10,
        child: _buildCornerDecoration(),
      ),
    ];
  }
  
  // Individual corner decoration
  Widget _buildCornerDecoration() {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.indigo.shade300, width: 2),
          left: BorderSide(color: Colors.indigo.shade300, width: 2),
        ),
      ),
    );
  }
}