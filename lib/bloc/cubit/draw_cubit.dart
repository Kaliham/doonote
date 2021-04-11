import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class DrawCubit extends Cubit<bool> {
  DrawCubit() : super(false);
  void change() => emit(!state);
  void set(bool value) => emit(value);
}

class DrawColorCubit extends Cubit<int> {
  DrawColorCubit() : super(0);
  void change(int newValue) => emit(newValue);
}
