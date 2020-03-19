import 'package:reduxauth/models/app_state.dart';
import 'package:reduxauth/reducers/app_state_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './config/app_config.dart' as config;
import './container/login.dart';
import './middleware/index.dart';
import './presentation/home_page.dart';
import './presentation/second_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((SharedPreferences prefs) {
    runApp(App(
      prefs: prefs,
    ));
  });
}

class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.init(),
    middleware: createStoreMiddleware()
  );

  final SharedPreferences prefs;
  App({this.prefs});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Redux Auth app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          brightness: Brightness.light,
          accentColor: config.Colors().mainColor(1),
          focusColor: config.Colors().textSecondeColor(1),
          hintColor: config.Colors().textAccentColor(1),
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
            headline: TextStyle(fontSize: 20.0, color: config.Colors().textSecondeColor(1)),
            display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().textSecondeColor(1)),
            display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().textSecondeColor(1)),
            display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color:Colors.white),
            display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().textSecondeColor(1)),
            subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().textSecondeColor(1)),
            title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().textMainColor(1)),
            body1: TextStyle(fontSize: 12.0, color: config.Colors().textSecondeColor(1)),
            body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().textSecondeColor(1)),
            caption: TextStyle(fontSize: 12.0, color: config.Colors().textAccentColor(0.6)),
          ),
        ),
        routes: {
          '/': (BuildContext context) {
            return _handleCurrentScreen(prefs);
          },
          '/home': (BuildContext context) {
            return HomePage();
          },
          '/second': (BuildContext context) {
            return SecondPage();
          }
        },
      ),
    );
  }

  Widget _handleCurrentScreen(SharedPreferences prefs) {
    // print('prefs: ${prefs.getString('token')}');
    final dynamic loginedIn = prefs.getString('token') ?? false;
    if (loginedIn != null && loginedIn != false) {
      return HomePage(prefs: prefs,);
    } else {
      return const LoginContainer();
    }
  }
}

