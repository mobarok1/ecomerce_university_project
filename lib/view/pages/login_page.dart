import 'package:ecomerce/models/dataClass/reponse_model.dart';
import 'package:ecomerce/models/service/login_register_service.dart';
import 'package:ecomerce/utils/theme_data.dart';
import 'package:ecomerce/view/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;


    return Scaffold(
      body: loading? Center(
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: InkWell(
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.close),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Flexible(
                flex: 7,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 120,
                        alignment: Alignment.center,
                        child: Image.asset("assets/logo.png"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        showCursor: true,
                        keyboardType: TextInputType.emailAddress,
                        validator: (str){
                          if(str!.isEmpty){
                            return "required";
                          }else{
                            return null;
                          }
                        },
                        controller: email,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: const Color(0xFF666666),
                            size: defaultIconSize,
                          ),
                          fillColor: const Color(0xFFF2F3F5),
                          hintStyle: TextStyle(
                              color: const Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize),
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        showCursor: true,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (str){
                          if(str!.isEmpty){
                            return "required";
                          }else{
                            return null;
                          }
                        },
                        controller: password,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: const Color(0xFF666666),
                            size: defaultIconSize,
                          ),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: const Color(0xFF666666),
                            size: defaultIconSize,
                          ),
                          fillColor: const Color(0xFFF2F3F5),
                          hintStyle: TextStyle(
                            color: const Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                          ),
                          hintText: "Password",
                        ),
                      ),


                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          padding: EdgeInsets.all(17.0),
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              login();
                            }
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins-Medium.ttf',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          color: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: mainColor)),
                        ),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>  RegisterPage()),
                          )
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async{
    setState(() {
      loading = true;
    });
    Map<String,dynamic> formData = {
      "email":email.text.toString(),
      "password":password.text.toString()
    };
    ResponseModel responseModel = await LoginRegisterService.loginNow(formData);
    setState(() {
      loading = false;
    });
    if(responseModel.statusCode == 200){
        Navigator.pop(context);
        logged = true;
    }else{
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("Failed to login"),backgroundColor: Colors.red[900],));
    }
  }
}

