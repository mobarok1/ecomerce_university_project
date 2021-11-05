import 'package:ecomerce/utils/theme_data.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              initialValue: user!.firstName+" "+user!.lastName,
              decoration: const InputDecoration(
                label: Text("Full Name"),
                border: OutlineInputBorder(

                )
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              initialValue: user!.email,
              decoration: const InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(

                  )
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              initialValue: user!.phoneNo,
              decoration: const InputDecoration(
                  label: Text("Phone"),
                  border: OutlineInputBorder(

                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
