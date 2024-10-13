import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/presentation/screens/change_address_screen/bloc/change_address_bloc.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/utils/styles.dart';

class ChangeAddressScreen extends StatelessWidget {
  final UserProfileModel userModel;

  ChangeAddressScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Address"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: BlocBuilder<ChangeAddressBloc, ChangeAddressState>(
          builder: (context, state) {
            if (state is FetchAddressChangeState) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: (){
                          context.read<ChangeAddressBloc>().add(
                              UpdateAddressChangeEvent(
                                  context:context,
                                  address:state.addressList[index].address));
                        },
                        child: ListTile(
                          leading: Radio(
                            value: index,
                            groupValue: state.selectedValue,
                            onChanged: (val) {
                              //addressModelCallback(state.addressList[val!]);

                              context.read<ChangeAddressBloc>().add(
                                  UpdateAddressChangeEvent(
                                    context:context,
                                  address:state.addressList[val!].address));
                            },
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.addressList[index].addressName,
                                style: style(fontSize: 19,
                                    color: Colors.black,
                                    weight: FontWeight.normal),),
                              Text(state.addressList[index].address, maxLines: 2,
                                overflow: TextOverflow.ellipsis,),
                              Text(state.addressList[index].addressPinCode,
                                style: style(fontSize: 15,
                                    color: Colors.grey,
                                    weight: FontWeight.normal),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.addressList.length,
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
