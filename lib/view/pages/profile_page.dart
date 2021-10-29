import 'package:ecomerce/utils/theme_data.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: ElevatedButton.icon(
                onPressed: (){
                  logged = false;
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red[900])
                ),
                icon: const Icon(Icons.logout),
                label: const Text("LOG OUT"),
              ),
            )
          ],
      ),
    );
  }
}
