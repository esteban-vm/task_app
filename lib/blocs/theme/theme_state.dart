part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.isDark});
  final bool isDark;

  @override
  List<Object> get props => [isDark];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDark': isDark,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      isDark: map['isDark'],
    );
  }
}

class InitialTheme extends ThemeState {
  const InitialTheme({required super.isDark});
}
