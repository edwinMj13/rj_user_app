import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/models/contact_us_data_model.dart';
import 'package:rj/features/data/repository/contact_us_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';
import 'package:rj/utils/text_controllers.dart';

part 'contact_us_event.dart';

part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsBloc() : super(ContactUsInitial()) {
    on<ContactUsPostDataEvent>(contactUsPostDataEvent);
  }

  Future<void> contactUsPostDataEvent(
      ContactUsPostDataEvent event, Emitter<ContactUsState> emit) async {
    final user = await CachedData.getUserDetails();
    await locator<ContactUsRepo>().uploadEnquiryDetails(ContactUsDataModel(
        subject: subjectController.text,
        body: detailsController.text,
        userId: user.nodeID)).then((_){
      subjectController.clear();
      detailsController.clear();
          emit(ContactUSSucessfullSTATE());
    });
  }
}
