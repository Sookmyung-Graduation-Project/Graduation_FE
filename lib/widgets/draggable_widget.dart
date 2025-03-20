import 'dart:math';
import 'package:flutter/material.dart';

class DraggableContainer extends StatefulWidget {
  final Function(Offset) onDragEnd; // 드래그 종료 시 실행할 콜백

  const DraggableContainer({super.key, required this.onDragEnd});

  @override
  _DraggableContainerState createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer>
    with SingleTickerProviderStateMixin {
  late Offset draggablePosition; // 드래그 가능한 박스 위치
  final Offset dropTargetPosition = const Offset(150, 300); // 드롭 위치
  late Offset initialPosition; // 초기 위치 저장
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    initialPosition = _getRandomPosition(); // 랜덤 초기 위치
    draggablePosition = initialPosition;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // 부드러운 이동
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

  /// 목표 위치로 이동 (자동 정렬)
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
        // 드래그 타겟 (드롭 위치)
        Positioned(
          left: dropTargetPosition.dx,
          top: dropTargetPosition.dy,
          child: DragTarget<Offset>(
            onWillAcceptWithDetails: (data) {
              double distance = (data.offset - dropTargetPosition).distance;
              return distance < 300; // 가까우면 드롭 가능
            },
            onAcceptWithDetails: (details) {
              _snapToTarget();
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: candidateData.isNotEmpty ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Aa",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // 드래그 가능한 박스
        Positioned(
          left: draggablePosition.dx,
          top: draggablePosition.dy,
          child: Draggable<Offset>(
            data: draggablePosition,
            feedback: Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Aa",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            childWhenDragging: Container(),
            child: Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
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
              child: const Center(
                child: Text(
                  "Aa",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
