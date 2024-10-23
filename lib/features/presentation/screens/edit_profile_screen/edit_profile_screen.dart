import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/presentation/widgets/textfield_address_details_widget.dart';
import 'package:rj/utils/common.dart';

import '../../../../utils/text_controllers.dart';
import '../../../domain/use_cases/edit_profile_cases.dart';
import 'bloc/edit_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {

  EditProfileScreen({Key? key, required this.user});

  final UserProfileModel user;

  @override
  Widget build(BuildContext context) {
    nameEditProfileController.text = user.name;
    emailEditProfileController.text = user.email;
    phoneEditProfileController.text = user.phoneNumber;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if(state is EditProfileEditedState){
              snackbar(context,"Changes Saved");
            }
          },
          child: Form(
            key: EditProfileCases.editProfileKey,
            child: ListView(
              children: [
                // Name Field
                TextFormField(
                  controller: nameEditProfileController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Email Field
                TextFormField(
                  controller: emailEditProfileController,
                  enabled: false,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Phone Number Field
                TextFormField(
                  controller: phoneEditProfileController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),

                // Save Button
                ElevatedButton(
                  onPressed: () =>
                      context.read<EditProfileBloc>().add(UpdateProfileEvent(
                        user: user, userNode: user.nodeID,)),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
