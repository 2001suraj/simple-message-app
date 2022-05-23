import 'package:flutter/material.dart';
import 'package:gangshit/login_screen.dart';
import 'package:gangshit/registration_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // GoogleSignIn googleSignIn = GoogleSignIn();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future signInFunction() async {
  //   GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //   if (googleUser == null) {
  //     return;
  //   }
  //   final googleAuth = await googleUser.authentication;

  //   final credential = await GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //   UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //   await firestore.collection('user').doc(userCredential.user!.uid).set({
  //     'email': userCredential.user!.email,
  //     'name': userCredential.user!.displayName,
  //     'uid': userCredential.user!.uid,
  //     'image': userCredential.user!.photoURL,
  //     'date ': DateTime.now(),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gang Shit",
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Colors.amber,
                  child: const Image(
                    image: AssetImage('assets/images/4.png'),
                    color: Colors.black26,
                  ),
                ),
              ),
              const Text(
                'Gang Shit',
                style: TextStyle(fontSize: 40, fontFamily: 'Signatra'),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=>const LoginScreen()));
              }, child:const  Text("Log in"),),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const RegistrationScreen()));
              }, child: const Text(" Register "),),
              Container(
                color: Colors.white30,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const RegistrationScreen()));
                      // await signInFunction();
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Image(
                            image: AssetImage('assets/images/google.webp'),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Sign in with google',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Monterrat',
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
