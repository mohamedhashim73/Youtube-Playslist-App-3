import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';
import 'auth_states.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context,state)
        {
          if( state is FailedToCreateUserState )
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,content: Text(state.message)));
            }
          if( state is UserCreatedSuccessState )
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }
        },
        builder: (context,state){
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                BlocProvider.of<AuthCubit>(context).userImgFile != null ?
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(BlocProvider.of<AuthCubit>(context).userImgFile!),
                          ),
                          SizedBox(height: 12,),
                          GestureDetector(
                            onTap: ()
                            {
                              BlocProvider.of<AuthCubit>(context).getImage();
                            },
                            child: const Text("Change Photo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          )
                        ],
                      )
                    ) :
                    OutlinedButton(
                      onPressed: ()
                      {
                        BlocProvider.of<AuthCubit>(context).getImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(Icons.image,color: Colors.green,),
                            SizedBox(width: 7,),
                            Text("Select Photo")
                          ],
                        ),
                      ),
                    ),
                SizedBox(height: 20,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                  ),
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: ()
                  {
                    if( emailController.text.isNotEmpty && passwordController.text.isNotEmpty )
                      {
                        BlocProvider.of<AuthCubit>(context).register(email: emailController.text, password: passwordController.text,name: nameController.text);
                      }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,content: Text("Please, fill The Textformfield and try again later")));
                      }
                  },
                  minWidth: double.infinity,
                  child: Text(state is RegisterLoadingState ? "Processing..." : "Sign Up"),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
