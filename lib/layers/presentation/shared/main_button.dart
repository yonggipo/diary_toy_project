import 'package:diary_toy_project/layers/application/common/app_color.dart';
import 'package:flutter/material.dart';

final class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    const addButtonInsets = EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 4.0,
    );
    return Container(
      padding: addButtonInsets,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.button,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
