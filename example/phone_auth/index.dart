library firebase.example.auth;

import 'dart:html';

import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/src/assets/assets.dart';

main() async {
  //Use for firebase package development only
  await config();

  try {
    fb.initializeApp(
        apiKey: apiKey,
        authDomain: authDomain,
        databaseURL: databaseUrl,
        storageBucket: storageBucket);

    new AuthApp();
  } on fb.FirebaseJsNotLoadedException catch (e) {
    print(e);
  }
}

class AuthApp {
  final fb.Auth auth;
  final FormElement registerForm;
  final InputElement phone;
  final AnchorElement logout;
  final HeadingElement authInfo;
  final ParagraphElement error;

  AuthApp()
      : this.auth = fb.auth(),
        this.phone = querySelector("#phone"),
        this.authInfo = querySelector("#auth_info"),
        this.error = querySelector("#register_form p"),
        this.logout = querySelector("#logout_btn"),
        this.registerForm = querySelector("#register_form") {
    logout.onClick.listen((e) {
      e.preventDefault();
      auth.signOut();
    });

    this.registerForm.onSubmit.listen((e) {
      e.preventDefault();
      var phoneValue = phone.value.trim();
      _registerUser(phoneValue);
    });

    // After opening
    if (auth.currentUser != null) {
      _setLayout(auth.currentUser);
    }

    // When auth state changes
    auth.onAuthStateChanged.listen((e) {
      fb.User u = e.user;
      _setLayout(u);
    });
  }

  _registerUser(String email) async {
    if (email.isNotEmpty) {
      try {
        var phoneProvider = new fb.PhoneAuthProvider();



      } catch (e) {
        error.text = e.toString();
      }
    } else {
      error.text = "Please fill correct e-mail and password.";
    }
  }

  void _setLayout(fb.User user) {
    if (user != null) {
      registerForm.style.display = "none";
      logout.style.display = "block";
      email.value = "";
      password.value = "";
      error.text = "";
      authInfo.style.display = "block";
      authInfo.text = user.email;
    } else {
      registerForm.style.display = "block";
      authInfo.style.display = "none";
      logout.style.display = "none";
      authInfo.children.clear();
    }
  }
}
