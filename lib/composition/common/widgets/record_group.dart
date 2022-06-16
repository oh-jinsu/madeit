import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/record_item.dart';

class RecordGroup extends StatelessWidget {
  final String? label;

  const RecordGroup({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          if (label != null) ...[
            Text(
              label!,
              textAlign: TextAlign.center,
              style: const CaptionTextStyle(),
            ),
            const SizedBox(height: 12.0),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacer(),
              Expanded(
                flex: 9,
                child: RecordItem(
                  icon: Icons.verified_outlined,
                  label: "잘했어요",
                  content: "101",
                ),
              ),
              Expanded(
                flex: 9,
                child: RecordItem(
                  icon: Icons.favorite_outline,
                  label: "좋아요",
                  content: "324",
                ),
              ),
              Expanded(
                flex: 9,
                child: RecordItem(
                  icon: Icons.waving_hand_outlined,
                  label: "힘내요",
                  content: "75",
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
