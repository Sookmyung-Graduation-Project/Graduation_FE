import 'dart:math';
import 'package:flutter/material.dart';

class DraggableContainer extends StatefulWidget {
  final Function(Offset) onDragEnd;
  final String text;
  final double screenWidth;
  final double screenHeight;

  const DraggableContainer({
    super.key,
    required this.onDragEnd,
    required this.text,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  _DraggableContainerState createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer>
    with SingleTickerProviderStateMixin {
  late Offset draggablePosition;
  final Offset dropTargetPosition = const Offset(150, 300);
  late Offset initialPosition;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    initialPosition = _getRandomPosition();
    draggablePosition = initialPosition;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: draggablePosition,
      end: dropTargetPosition,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.addListener(() {
      setState(() {
        draggablePosition = _animation.value;
      });
    });
  }

  Offset _getRandomPosition() {
    final random = Random();
    double x = random.nextDouble() * 300;
    double y = random.nextDouble() * 500;
    return Offset(x, y);
  }

  void _snapToTarget() {
    _animation = Tween<Offset>(
      begin: draggablePosition,
      end: dropTargetPosition,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 드롭 타겟
        Positioned(
          left: dropTargetPosition.dx,
          top: dropTargetPosition.dy,
          child: DragTarget<Offset>(
            onWillAcceptWithDetails: (data) {
              double distance = (data.offset - dropTargetPosition).distance;
              return distance < 300;
            },
            onAcceptWithDetails: (_) {
              _snapToTarget();
            },
            builder: (context, candidateData, rejectedData) {
              return _buildLetterCard(
                widget.text,
                candidateData.isNotEmpty ? Colors.green : Colors.red,
                textColor: Colors.white,
              );
            },
          ),
        ),

        // 드래그 가능한 카드
        Positioned(
          left: draggablePosition.dx,
          top: draggablePosition.dy,
          child: Draggable<Offset>(
            data: draggablePosition,
            feedback: _buildLetterCard(widget.text, Colors.grey),
            childWhenDragging: Container(),
            child: _buildLetterCard(widget.text, Colors.black),
            onDragEnd: (details) {
              setState(() {
                draggablePosition = details.offset;
              });

              if ((draggablePosition - dropTargetPosition).distance < 50) {
                _snapToTarget();
              } else {
                widget.onDragEnd(draggablePosition);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLetterCard(String letter, Color borderColor,
      {Color? textColor}) {
    return Container(
      width: widget.screenWidth * 0.55555555555,
      height: widget.screenHeight * 0.17462165308,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            color: textColor ?? borderColor,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
