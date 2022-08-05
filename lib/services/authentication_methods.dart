import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/services/cloud_firestore.dart';
import 'package:firebase_login/services/user_detail_model.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  Future<String> signUpUser(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    name.trim();
    phone.trim;
    email.trim();
    password.trim();
    String output = "Somethimg went Wrong";

    if (name != "" && phone != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        userDetailModel user = userDetailModel(
            name: name, phone: phone, email: email, password: password);
        await cloudFirestoreClass.uploadNameAndphoneToDatabase(user: user);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up everything";
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Somethimg went Wrong";

    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up everything";
    }
    return output;
  }

  Future<String> AdminsignInUser(
      {required String userName, required String password}) async {
    userName.trim();
    password.trim();
    String output = "Somethimg went Wrong";

    if (userName == "Admin" && password == "0000") {
      try {
        // await firebaseAuth.signInWithEmailAndPassword(
        //     email: userName, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up everything";
    }
    return output;
  }
}
