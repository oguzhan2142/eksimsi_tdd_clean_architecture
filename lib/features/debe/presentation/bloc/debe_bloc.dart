import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'debe_event.dart';
part 'debe_state.dart';

class DebeBloc extends Bloc<DebeEvent, DebeState> {
  DebeBloc() : super(DebeInitial()) {}
}
