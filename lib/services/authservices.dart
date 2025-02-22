import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{


  final FirebaseAuth _auth=FirebaseAuth.instance;

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  User? getCurrentUser(){
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email,password) async{
    try
        {
          UserCredential userCredential= await _auth.signInWithEmailAndPassword(email: email, password: password,);


          //save user info in separate doc
          _firestore.collection("users").doc(userCredential.user!.uid).set({
            'uid':userCredential.user!.uid,
            'email':email,
          });

          return userCredential;

        } on FirebaseAuthException catch (e){
      throw Exception(e);
    }
  }


  Future<UserCredential> signUpWithEmailAndPassword(String email,password) async{
    try
    {
      UserCredential userCredential= await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,);

      //save user info in separate doc
      _firestore.collection("users").doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email':email,
      });


      return userCredential;

    } on FirebaseAuthException catch (e){
      throw Exception(e);
    }
  }


  Future<void> SignOut()async{
    return await _auth.signOut();
  }
  //google sign in
  signInWithGoogle() async {
    //interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtaining detail
    final GoogleSignInAuthentication gAuth= await gUser!.authentication;

    //creating credentials
    final credential= GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //user sign in wrapped up
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

}
