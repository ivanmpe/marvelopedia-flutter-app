import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

/*   final FirebaseUser user = await _auth.signInWithCredential(credential);
 */
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
/*   if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  } */

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  name = '';
  email = '';
  imageUrl = '';
  await googleSignIn.signOut();

  print("User Sign Out");
}

Widget iconProfileAppBar() {
  if (imageUrl != '')
    return Container(
      width: 40,
      height: 40,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ),
        radius: 60,
        backgroundColor: Colors.transparent,
      ),
    );

  return Icon(Icons.person, color: Colors.white);
}
