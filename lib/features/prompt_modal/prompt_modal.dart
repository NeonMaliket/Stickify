import 'package:flutter/material.dart';
import 'package:stickify/core/core.dart';

class PromptModal extends StatefulWidget {
  const PromptModal({super.key, required this.onSend});

  final Function(String) onSend;

  @override
  State<PromptModal> createState() => _PromptModalState();
}

class _PromptModalState extends State<PromptModal> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.vh(50),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter prompt',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final prompt = _controller.text;
                  widget.onSend(prompt);
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
