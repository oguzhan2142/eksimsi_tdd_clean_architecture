import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'debe_event.dart';
part 'debe_state.dart';
class DebeBloc extends Bloc<DebeEvent, DebeState> {
  DebeBloc() : super(DebeInitial());
  @override
  Stream<DebeState> mapEventToState(
    DebeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
