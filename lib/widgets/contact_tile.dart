import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String number;

  ContactTile({
    required this.name,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/logo/logo.png',
            width: 44,
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  number,
                  style: TextStyle(color: Colors.amber),
                ),
                SizedBox(
                  height: 18,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
