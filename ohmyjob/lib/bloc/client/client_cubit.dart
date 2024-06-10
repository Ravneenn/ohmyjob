import 'package:flutter_bloc/flutter_bloc.dart';
part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit(super.initialState);

  changeLanguage({required String newLanguage}) {
    final newState =
        ClientState(language: newLanguage, darkMode: state.darkMode);

    emit(newState);
  }

  changeDarkMode({required bool newDarkMode}) {
    final newState =
        ClientState(language: state.language, darkMode: newDarkMode);

    emit(newState);
  }
}
