import 'package:flutter/material.dart';
import 'package:flutter_google/google_login_controller.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Login'),
        backgroundColor: Colors.redAccent,
      ),
      body: loginUI(),
    );
  }

  loginUI() {
    return Consumer<GoogleSignInController>(
      builder: (context, model, child){
        if(model.googleAccount != null){
          return loggedInUI(model);
        } 
        else{
          return loginControls(context);
        }
      },
    );
  }

  loggedInUI(GoogleSignInController model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: Image.network(model.googleAccount!.photoUrl ?? '').image,
            radius: 50,
          ),
          Text(model.googleAccount!.displayName ?? ''),
          Text(model.googleAccount!.email),
          ActionChip(
            avatar: Icon(Icons.logout),
            label: Text('Logout'),
            onPressed: () {
              Provider.of<GoogleSignInController>(context, listen: false).logOut();
            }
          )
        ],
      ),
    );
  }
  loginControls(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: Image.asset("assets/images/google1.png", width: 250,),
            onTap: (){
              Provider.of<GoogleSignInController>(context, listen: false).login();
            },
          )
        ],
      ),
    );
  }
}