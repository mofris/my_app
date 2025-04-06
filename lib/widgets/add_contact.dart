import 'package:flutter/material.dart';
import 'package:my_app/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  bool isLoading = false;

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

  void saveContact() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final contactProvider =
          Provider.of<ContactProvider>(context, listen: false);
      bool success = await contactProvider.addContact(
        nameController.text,
        numberController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        Navigator.of(context).pop();
        showNotificationSuccess('Kontak berhasil ditambahkan');
      } else {
        Navigator.of(context).pop();
        showNotificationFailed('Gagal menambahkan kontak');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tambah Kontak"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
              validator: (value) =>
                  value == null || value.isEmpty ? "Wajib diisi" : null,
            ),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(labelText: "Nomor"),
              validator: (value) =>
                  value == null || value.isEmpty ? "Wajib diisi" : null,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Batal",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : saveContact,
          child: isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Simpan"),
        ),
      ],
    );
  }
}
