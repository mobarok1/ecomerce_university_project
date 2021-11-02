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
              decoration: InputDecoration(
                label: Text("Full Name"),
                border: OutlineInputBorder(

                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(

                  )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  label: Text("Phone"),
                  border: OutlineInputBorder(

                  )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  label: Text("Address"),
                  border: OutlineInputBorder(

                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
