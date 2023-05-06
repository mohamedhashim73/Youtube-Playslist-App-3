import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/constants.dart';
import '../../models/user_model.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(InitialAppState());

  File? userImgFile;
  void getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if( pickedImage != null )
      {
        userImgFile = File(pickedImage.path);
        emit(UserImageSelectedSuccessState());
      }
    else
      {
        emit(FailedToGeUserImageSelectedState());
      }
  }

  Future<String> uploadImageToStorage() async {
    debugPrint("File is : $userImgFile}");
    debugPrint("Base Name fro File is : ${basename(userImgFile!.path)}");
    Reference imageRef = FirebaseStorage.instance.ref(basename(userImgFile!.path));
    await imageRef.putFile(userImgFile!);
    return await imageRef.getDownloadURL();
  }

  // register
  void register({required String email,required String name,required String password}) async {
    emit(RegisterLoadingState());
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if( userCredential.user?.uid != null )
      {
        debugPrint("User Created success with uid : ${userCredential.user!.uid}");
        String imgUrl = await uploadImageToStorage();
        debugPrint("Image Url is : $imgUrl");
        await sendUserDataToFirestore(name: name, email: email, password: password, userID: userCredential.user!.uid,url: imgUrl );
        emit(UserCreatedSuccessState());
      }
    }
    on FirebaseAuthException catch(e){
      debugPrint("Failed To Register, reason is : ${e.code}");
      if( e.code == "email-already-in-use" )
      {
        emit(FailedToCreateUserState(message: 'Email already in use'));
      }
      if( e.code == "weak-password" )
      {
        emit(FailedToCreateUserState(message: 'Weak Password'));
      }
    }
  }

  Future<void> sendUserDataToFirestore({required String url,required String name,required String email,required String password,required String userID}) async {
    UserModel userModel = UserModel(name: name, email: email, image: url, id: userID);
    try{
      await FirebaseFirestore.instance.collection('Users').doc(userID).set(userModel.toJson());
      emit(SaveUserDataOnFirestoreSuccessState());
    }
    on FirebaseException catch(e)
    {
      emit(FailedToSaveUserDataOnFirestoreState());
    }
  }

  void login({required String email,required String password}) async {
    emit(LoginLoadingState());
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if( userCredential.user?.uid != null )
      {
        // save id cache
        final sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setString('userID', userCredential.user!.uid);
        Constants.userID = sharedPref.getString('userID');
        emit(LoginSuccessState());
      }
    }
    on FirebaseAuthException catch(e){
      print("Error is : ${e.code}");
      emit(FailedToLoginState());
    }
  }
}