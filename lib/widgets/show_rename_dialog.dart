import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<String?> showRenameVoiceDialog(BuildContext context) {
  String? input;
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('음성 이름 변경'),
        content: TextField(
          onChanged: (value) => input = value,
          decoration: const InputDecoration(
            hintText: '새 음성 이름을 입력하세요',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => context.pop(input),
            child: const Text('변경'),
          ),
        ],
      );
    },
  );
}
