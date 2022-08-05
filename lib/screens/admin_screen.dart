import 'package:firebase_login/screens/admin_user_list.dart';
import 'package:firebase_login/services/authentication_methods.dart';
import 'package:firebase_login/utils/colors.dart';
import 'package:firebase_login/utils/utils.dart';
import 'package:flutter/material.dart';

import '../widget/custom_main_button.dart';
import '../widget/text_field_widget.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://scbb.ihbt.res.in/SCBB_dept/video_tutorial/vd/examples/images/Swan_large.jpg",
                      height: screenSize.height * 0.10,
                    ),
                    Container(
                      height: screenSize.height * 0.6,
                      width: screenSize.width * 0.9,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin Sign-In",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 33,
                                color: Colors.grey.shade500),
                          ),
                          TextFieldWidget(
                              hintText: 'Enter Username',
                              title: 'Username',
                              controller: userNameController,
                              obscureText: false),
                          TextFieldWidget(
                              hintText: 'Enter Password',
                              title: 'Password',
                              controller: passwordController,
                              obscureText: true),
                          Align(
                            alignment: Alignment.center,
                            child: CustomMainButton(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    letterSpacing: 0.6,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              color: activeCyanColor,
                              isLoading: false,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Future.delayed(Duration(seconds: 1));
                                String output =
                                    await authenticationMethods.AdminsignInUser(
                                        userName: userNameController.text,
                                        password: passwordController.text);
                                setState(() {
                                  isLoading = false;
                                });

                                if (output == 'success') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminUserList()));
                                } else {
                                  Utils().showSnackBar(
                                      context: context, content: output);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
