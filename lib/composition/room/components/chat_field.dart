import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/events/message_chat_submitted.dart';

class ChatField extends StatefulWidget {
  final String roomId;

  final FocusNode focusNode;

  const ChatField({
    Key? key,
    required this.roomId,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.focusNode.requestFocus();
      },
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey[200]!,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                ),
                child: TextField(
                  controller: textEditingController,
                  focusNode: widget.focusNode,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(0.0),
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {},
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final value = textEditingController.text;

                if (value.isEmpty) {
                  return;
                }

                dispatch(
                  MessageChatSubmitted(
                    roomId: widget.roomId,
                    message: value,
                  ),
                );

                textEditingController.text = "";
              },
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                fixedSize: const Size(32.0, 32.0),
                minimumSize: const Size(32.0, 32.0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: const Icon(
                Icons.arrow_upward,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
