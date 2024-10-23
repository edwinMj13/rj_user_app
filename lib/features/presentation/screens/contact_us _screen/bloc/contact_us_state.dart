part of 'contact_us_bloc.dart';

@immutable
sealed class ContactUsState {}

final class ContactUsInitial extends ContactUsState {}

final class ContactUSSucessfullSTATE extends ContactUsState {}