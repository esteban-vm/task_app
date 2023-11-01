import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const InitialTheme(isDark: false)) {
    on<DarkOn>((event, emit) {
      emit(const ThemeState(isDark: true));
    });

    on<DarkOff>((event, emit) {
      emit(const ThemeState(isDark: false));
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) => ThemeState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(ThemeState state) => state.toMap();
}
