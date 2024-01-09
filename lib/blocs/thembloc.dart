import 'package:blocnewsdemo/blocs/themeevent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utiles/Theme.dart';
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: lightTheme)) {
    on<ToggleTheme>((event, emit) {
      final newTheme = state.theme == lightTheme ? darkTheme : lightTheme;
      emit(ThemeState(theme: newTheme));
    });
  }

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ToggleTheme) {
      final newTheme = state.theme == lightTheme ? darkTheme : lightTheme;
      yield ThemeState(theme: newTheme);
    }
  }
}
