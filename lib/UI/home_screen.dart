import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/layout_cubit.dart';
import '../Controller/layout_states.dart';
import 'chat_screen.dart';
class HomeScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)..getMyData()..getUsers();
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  if( layoutCubit.userModel != null )
                    UserAccountsDrawerHeader(
                      accountName: Text(layoutCubit.userModel!.name!),
                      accountEmail: Text(layoutCubit.userModel!.email!),
                      currentAccountPicture: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(layoutCubit.userModel!.image!),
                      ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("log out"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              title: layoutCubit.searchEnabled ? TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (input)
                {
                  layoutCubit.searchAboutUser(query: input);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search about User....',
                  hintStyle: TextStyle(color: Colors.white)
                ),
              ) : GestureDetector(
                  child: Text("Chat"),
                  onTap: ()
                  {
                    scaffoldKey.currentState!.openDrawer();
                  },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    child: Icon(layoutCubit.searchEnabled ? Icons.clear : Icons.search),
                    onTap: ()
                    {
                      layoutCubit.changeSearchStatus();
                    },
                  ),
                )
              ],
              automaticallyImplyLeading: false,elevation: 0,),
            body: state is GetUsersLoadingState ?
              const Center(
                child: CircularProgressIndicator(),
               ) : layoutCubit.users.isNotEmpty ?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
                child: ListView.separated(
                  itemCount: layoutCubit.usersFiltered.isEmpty ? layoutCubit.users.length : layoutCubit.usersFiltered.length,
                    separatorBuilder: (context,index) => const SizedBox(height: 18,),
                    itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ChatScreen(userModel: layoutCubit.usersFiltered.isEmpty? layoutCubit.users[index] : layoutCubit.usersFiltered[index]);
                        }));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          layoutCubit.usersFiltered.isEmpty ? layoutCubit.users[index].image! : layoutCubit.usersFiltered[index].image!
                        ),
                      ),
                      title: Text(layoutCubit.usersFiltered.isEmpty ? layoutCubit.users[index].name! : layoutCubit.usersFiltered[index].name!),
                    );
                    }
            ),
              ) : const Center(
              child: Text("There is no Users yet"),
            ),
          );
        },
    );
  }
}
