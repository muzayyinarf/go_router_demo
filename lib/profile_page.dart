import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page', style: GoogleFonts.inter())),
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
                Text(
                  state is UserSignedIn ? state.user.name : '-',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: 200,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        context.goNamed('edit_profile');
                      },
                      child: Text('Edit Profile',
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
