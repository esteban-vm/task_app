import 'package:task_app/blocs/bloc_exports.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(bloc, event) {
    super.onEvent(bloc, event);
    print('${bloc.runtimeType} $event');
  }

  @override
  void onError(bloc, error, stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error);
  }

  @override
  void onChange(bloc, change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onTransition(bloc, transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
