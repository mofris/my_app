import 'package:flutter/material.dart';
import 'package:my_app/models/contact_model.dart';
import 'package:my_app/providers/contact_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/widgets/add_contact.dart';
import 'package:my_app/widgets/contact_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var contactProvider = Provider.of<ContactProvider>(context);

    // Set status bar transparan dan icon putih
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    Widget header() {
      return Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          left: 15,
          right: 15,
          bottom: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    'MOBILE CONTACT APPS',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    'version : 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget contact() {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: FutureBuilder<List<ContactModel>>(
            future: contactProvider.getContacts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final contacts = snapshot.data ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Your Contact',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (contacts.isEmpty)
                    const Center(
                      child: Text(
                        'Tidak ada data',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  else
                    ...contacts.map((contact) {
                      return ContactTile(
                        id: contact.id ?? 0,
                        name: contact.name ?? '-',
                        number: contact.number ?? '-',
                      );
                    }).toList(),
                ],
              );
            },
          ),
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            header(),
            contact(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AddContact();
              },
            );
          },
          tooltip: 'Tambah Kontak',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
