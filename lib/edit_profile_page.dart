import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/user.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/user_bloc.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Edit Profile Page', style: GoogleFonts.inter())),
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.person_sharp,
                      size: 70,
                      color: Colors.blueGrey.shade800,
                    )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: TextField(
                    controller: TextEditingController(
                        text: state is UserSignedIn ? state.user.name : '-'),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Name'),
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: TextField(
                    controller: TextEditingController(
                        text: state is UserSignedIn ? state.user.email : '-'),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () => context.goNamed('main_page'),
                      child: Text('Go to Main Page',
                          style:
                              GoogleFonts.inter(fontWeight: FontWeight.bold))),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
