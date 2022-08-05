import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  showModelBox(String docId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.tealAccent,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                  ),
                  controller: _phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Phone number";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(docId)
                        .update({
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                    }).then((value) {
                      _nameController.text = "";
                      _phoneController.text = "";
                      _emailController.text = "";
                      _passwordController.text = "";
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: size.height * 0.20,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 140,
                                color: Colors.blue,
                                child:
                                    Text(snapshots.data!.docs[index]['name']),
                              ),
                              Container(
                                width: 140,
                                color: Colors.green,
                                child:
                                    Text(snapshots.data!.docs[index]['phone']),
                              ),
                              Container(
                                width: 140,
                                color: Colors.yellowAccent,
                                child:
                                    Text(snapshots.data!.docs[index]['email']),
                              ),
                              Container(
                                width: 140,
                                color: Colors.orangeAccent,
                                child: Text(
                                    snapshots.data!.docs[index]['password']),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _nameController.text =
                                        snapshots.data!.docs[index]['name'];
                                    _phoneController.text =
                                        snapshots.data!.docs[index]['phone'];
                                    _emailController.text =
                                        snapshots.data!.docs[index]['email'];
                                    _passwordController.text =
                                        snapshots.data!.docs[index]['password'];
                                    showModelBox(
                                        snapshots.data!.docs[index].id);
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                        ),
                      ));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
