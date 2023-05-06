import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/layout_cubit.dart';
import '../Controller/layout_states.dart';
import '../models/user_model.dart';

class ChatScreen extends StatelessWidget {
  final UserModel userModel;
  final messageController = TextEditingController();
  ChatScreen({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context)..getMessages(receiverID: userModel.id!);
    return Scaffold(
      appBar: AppBar(title: Text(userModel.name!),elevation:0,automaticallyImplyLeading: false,),
      body: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state)
        {
          if( state is SendMessageSuccessState )
            {
              messageController.clear();
            }
        },
        builder: (context,state){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              children:
              [
                Expanded(
                  child: state is GetMessagesLoadingState ?
                  const Center(child: CircularProgressIndicator()) :
                  cubit.messages.isNotEmpty ?
                    ListView.builder(
                            itemCount: cubit.messages.length,
                            itemBuilder: (context,index){
                              return Container(
                                color: Colors.blueGrey,
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                child: Text(cubit.messages[index].content!,style: const TextStyle(
                                  color: Colors.white,fontSize: 18
                                ),),
                              );
                            },
                          ) :
                    const Center(child: Text("No Messages yet....."),)
                ),
                const SizedBox(height: 12,),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.send),
                        onTap: ()
                        {
                          // Send Message to Firestore
                          cubit.sendMessage(message: messageController.text, receiverID: userModel.id!);
                        },
                      ),
                      border: OutlineInputBorder(

                      )
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
