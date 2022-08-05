import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteUserList extends StatefulWidget {
  const DeleteUserList({Key? key}) : super(key: key);

  @override
  State<DeleteUserList> createState() => _DeleteUserListState();
}

class _DeleteUserListState extends State<DeleteUserList> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deleted Users"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ListTile(
                        title: Text(
                          snapshots.data!.docs[index]['email'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
