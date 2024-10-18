import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_address_with_map_event.dart';
part 'add_address_with_map_state.dart';

class AddAddressWithMapBloc extends Bloc<AddAddressWithMapEvent, AddAddressWithMapState> {
  AddAddressWithMapBloc() : super(AddAddressWithMapInitial()) {
    on<AddAddressWithMapEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
