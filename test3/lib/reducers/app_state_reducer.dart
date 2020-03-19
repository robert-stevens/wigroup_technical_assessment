import '../models/model.dart';
import './login_reducer.dart';

// Combine many smaller reducers into one
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    login: loginReducer(state.login, action),
  );
}