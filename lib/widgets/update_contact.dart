import 'package:flutter/material.dart';
import 'package:my_app/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class UpdateContactDialog extends StatefulWidget {
  final int id;
  final String name;
  final String number;

  const UpdateContactDialog({
    required this.id,
    required this.name,
    required this.number,
  });

  @override
  State<UpdateContactDialog> createState() => _UpdateContactDialogState();
}

class _UpdateContactDialogState extends State<UpdateContactDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController numberController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    numberController = TextEditingController(text: widget.number);
  }

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

  void updateContact() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final contactProvider =
          Provider.of<ContactProvider>(context, listen: false);
      bool success = await contactProvider.updateContact(
        widget.id,
        nameController.text,
        numberController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        Navigator.of(context).pop();
        showNotificationSuccess('Data kontak berhasil diperbarui');
      } else {
        showNotificationFailed('Data kontak gagal diperbarui');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update Kontak"),
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
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : updateContact,
          child: isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text("Update"),
        ),
      ],
    );
  }
}
