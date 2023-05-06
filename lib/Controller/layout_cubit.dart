import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Core/constants.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(LayoutInitialState());

  UserModel? userModel;
  void getMyData() async {
    try{
      await FirebaseFirestore.instance.collection('Users').doc(Constants.userID!).get().then((value){
        userModel = UserModel.fromJson(data: value.data()!);
      });
      emit(GetMyDataSuccessState());
    }
    on FirebaseException catch(e){
      emit(FailedToGetMyDataState());
    }
  }

  List<UserModel> users = [];
  void getUsers() async {
    users.clear();
    emit(GetUsersLoadingState());
    try{
      await FirebaseFirestore.instance.collection('Users').get().then((value){
        for( var item in value.docs )
        {
          if( item.id != Constants.userID )
          {
            users.add(UserModel.fromJson(data: item.data()));
          }
        }
        emit(GetUsersDataSuccessState());
      });
    }
    on FirebaseException catch(e){
      users = [];
      emit(FailedToGetUsersDataState());
    }
  }

  List<UserModel> usersFiltered = [];
  void searchAboutUser({required String query}){
    usersFiltered = users.where((element) => element.name!.toLowerCase().startsWith(query.toLowerCase())).toList();
    emit(FilteredUsersSuccessState());
  }

  bool searchEnabled = false;
  void changeSearchStatus(){
    searchEnabled = !searchEnabled;
    if( searchEnabled == false ) usersFiltered.clear();
    emit(ChangeSearchStatusSuccessState());
  }

  void sendMessage({required String message,required String receiverID}) async {
    MessageModel messageModel = MessageModel(content: message, date: DateTime.now().toString(), senderID: Constants.userID);
    // Save Data on my Document
    await FirebaseFirestore.instance.collection("Users").doc(Constants.userID).collection("Chat")
        .doc(receiverID).collection("Messages").add(messageModel.toJson());
    debugPrint("Message Sent success ......");
    // Save Data on Receiver Document
    await FirebaseFirestore.instance.collection("Users").doc(receiverID).collection("Chat")
        .doc(Constants.userID).collection("Messages").add(messageModel.toJson());
    emit(SendMessageSuccessState());
  }

  List<MessageModel> messages = [];
  void getMessages({required String receiverID}){
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(Constants.userID).collection('Chat')
        .doc(receiverID).collection('Messages').orderBy('date').snapshots().listen((value){
          messages.clear();
          for( var item in value.docs )
            {
              messages.add(MessageModel.fromJson(data: item.data()));
            }
          debugPrint("Messages length is : ${messages.length}");
          emit(GetMessagesSuccessState());
    });
  }

}