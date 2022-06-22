import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/record_item.dart';

class RecordGroup extends StatelessWidget {
  final String? label;
  final List<RecordItem> items;

  const RecordGroup({Key? key, this.label, this.items = const []})
      : super(key: key);

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
            children: [
              const Spacer(),
              for (final item in items)
                Expanded(
                  flex: 9,
                  child: item,
                ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
