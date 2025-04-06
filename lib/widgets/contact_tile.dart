import 'package:flutter/material.dart';
import 'package:my_app/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ContactTile extends StatelessWidget {
  final int id;
  final String name;
  final String number;

  ContactTile({
    required this.id,
    required this.name,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    void showNotificationSuccess(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(message),
        ),
      );
    }

    void showNotificationFailed(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[500],
          content: Text(message),
        ),
      );
    }

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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Konfirmasi"),
                        content: const Text(
                            "Apakah kamu yakin ingin menghapus data ini?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Tutup dialog
                            },
                            child: const Text("Batal"),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(); // Tutup dialog dulu

                              final provider = Provider.of<ContactProvider>(
                                  context,
                                  listen: false);
                              final response = await provider.deleteContact(id);

                              if (response) {
                                showNotificationSuccess(
                                  'Data berhasil dihapus',
                                );
                              } else {
                                showNotificationFailed(
                                  'Gagal menghapus data',
                                );
                              }
                            },
                            child: const Text(
                              "Hapus",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
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
