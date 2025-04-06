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
      onTap: () {
        print('object');
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/img/avatar.png',
                width: 44,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      number,
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => {
                  // Aksi hapus
                  print('Delete pressed')
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
