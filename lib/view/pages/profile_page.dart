import 'package:ecomerce/utils/theme_data.dart';
import 'package:flutter/material.dart';

import 'order_history.dart';
import 'personal_info_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        elevation: 0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   SizedBox(
                     height: 50,
                     child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const PersonalInfo()));
                      },
                      child: Row(
                        children: const [
                          Padding(
                              padding: EdgeInsets.only(
                                left: 10, right: 10
                              ),
                            child: Icon(Icons.person),
                          ),
                          Text("Personal Information",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                  ),
                   ),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    height: 50,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const OrderHistory()));
                      },
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10
                            ),
                            child: Icon(Icons.reorder),
                          ),
                          Text("Order History",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: (){
                  user = null;
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
