
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_screen.dart';
import 'auth_cubit.dart';
import 'auth_states.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context,state){
          if( state is LoginSuccessState )
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          if( state is FailedToLoginState )
            {

            }
        },
        builder: (context,state){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email'
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                  ),
                ),
                SizedBox(height: 15,),
                MaterialButton(
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: ()
                  {
                    if( emailController.text.isNotEmpty && passwordController.text.isNotEmpty )
                    {
                      BlocProvider.of<AuthCubit>(context).login(email: emailController.text, password: passwordController.text);
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,content: Text("Please, fill The Textformfield and try again later")));
                    }
                  },
                  minWidth: double.infinity,
                  child: Text(state is LoginLoadingState ? "Processing" : "Login"),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
