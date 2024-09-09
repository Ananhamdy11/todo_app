import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubitCubit extends Cubit<NavigationCubitState> {
  NavigationCubitCubit() : super(NavigationCubitInitial());
}
