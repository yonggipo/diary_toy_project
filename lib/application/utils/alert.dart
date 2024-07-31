import 'package:flutter/material.dart';

final class AlertAction {
  const AlertAction({this.title = "OK", this.onTap});

  final String title;
  final VoidCallback? onTap;
}

Future<void> showAlert({
  required context,
  required String title,
  required String body,
  required List<AlertAction> actions,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(body),
          ],
        ),
      ),
      actions: actions
          .map((e) => TextButton(
                onPressed: e.onTap,
                child: Text(e.title),
              ))
          .toList(),
    ),
  );
}
