import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:flutter/material.dart';

void showUserDetailsDialog(BuildContext context, Usermodel data) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          data.name ?? '',
          style: const TextStyle(color: Colors.purple, fontFamily: "Outfit"),
        ),
        content: Row(
          children: [
            Text((data.gender ?? '').toUpperCase()),
            const Text(' '),
            Text(
              ' ${(data.status ?? '').toUpperCase()}',
              style: TextStyle(
                color: data.status == 'active' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      );
    },
  );
}
