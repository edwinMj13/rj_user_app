import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/contact_us%20_screen/bloc/contact_us_bloc.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';

import '../../../../utils/text_controllers.dart';


class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final _formKey = GlobalKey<FormState>();



  nextFocus(FocusNode focusNode, BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  submitForm() {}

  //  _validateFields(String? val){
  //   if(val.trim().isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(val)){
  //     return "Entre Correct Name";
  //   }else{
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizedH20,
            const CallEmailTile(),
            sizedH20,
            BlocListener<ContactUsBloc, ContactUsState>(
              listener: (context, state) {
                if (state is ContactUSSucessfullSTATE) {
                  snackbar(context,'Submitted');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        focusNode: subjectFocusNode,
                        controller: subjectController,
                        onFieldSubmitted: (val) {
                          nextFocus(detailsFocusNode, context);
                        },
                        validator: (val) {
                          if (val!.trim().isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                            return "Enter Subject";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter Subject',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      sizedH10,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: detailsController,
                        minLines: 5,
                        maxLines: 8,
                        maxLength: 150,
                        validator: (val) {
                          if (val!.trim().isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                            return "Entre Details";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter Details',
                          //labelText: 'Enter Details',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ContactUsBloc>().add(ContactUsPostDataEvent());
                        }
                      }, child: Text("Submit")),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CallEmailTile extends StatelessWidget {
  const CallEmailTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 0),
                blurStyle: BlurStyle.normal,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filled(
                onPressed: () {},
                splashRadius: 6,
                icon: Icon(
                  Icons.call,
                  size: 30,
                  color: Colors.red[300],
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red[100],
                ),
              ),
              sizedH10,
              Text(
                'Call Us',
                style: TextStyle(color: Colors.red[300],
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 0),
                blurStyle: BlurStyle.normal,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filled(
                onPressed: () {},
                splashRadius: 6,
                icon: Icon(
                  Icons.alternate_email_outlined,
                  size: 30,
                  color: Colors.blue[300],
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                ),
              ),
              sizedH10,
              Text(
                'Email Us',
                style: TextStyle(
                    color: Colors.blue[300],
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}