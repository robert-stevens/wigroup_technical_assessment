import 'package:redux/redux.dart';
import '../actions/actions.dart';
import '../models/model.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/index.dart';

String url = 'http://10.10.160.37:3000/login';

List<Middleware<AppState>> createStoreMiddleware() {
  final loginUser = _loginUser();

  return [
    TypedMiddleware<AppState, LoginAction>(loginUser),
    LoggingMiddleware<dynamic>.printer()
  ];
}

Middleware<AppState> _loginUser() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    final Login login = store.state.login;
    final Map map = {'email': login.email, 'password': login.password};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    if (login.email != null && login.password != null) {
      login.callbackFn(); // login succesfull pop screen 
      store.dispatch(ChangeLoginAction(Login(loading: false)));
      await prefs.setString('token', 'myfaketoken');
    }
    // print(store.state);
  };
}