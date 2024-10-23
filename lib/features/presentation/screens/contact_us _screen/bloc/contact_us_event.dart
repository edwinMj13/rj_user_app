part of 'contact_us_bloc.dart';

@immutable
sealed class ContactUsEvent {}

class ContactUsPostDataEvent extends ContactUsEvent {
  ContactUsPostDataEvent();
}