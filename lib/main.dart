import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'box_provider.dart';
import 'generated/i18n.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<BoxProvider>(
          builder: (context) => BoxProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        localeResolutionCallback: (Locale locale, Iterable<Locale> supported) {
          bool isSupported(Locale locale) {
            if (locale == null) return false;
            if (supported.contains(locale)) {
              return true;
            } else {
              for (Locale supportedLocale in supported) {
                if (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)
                  if (supportedLocale.languageCode == locale.languageCode) return true;
              }
              return false;
            }
          }

          if (!isSupported(locale))
            return supported.first;

          final Locale languageLocale = Locale(locale.languageCode, "");
          if (supported.contains(locale)) return locale;
          else if (supported.contains(languageLocale)) return languageLocale;
          else return supported.first;
        },


        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(S.of(context).app_box),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).app_information,
            ),
            Consumer<BoxProvider>(
              builder: (context,model,_){
                return Text(
                  model.index().toString(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return SettingPage();
          }));
        },
        tooltip: 'Increment',
        child: Icon(Icons.navigate_next),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(S.of(context).app_box),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).app_information,
            ),
            Consumer<BoxProvider>(
             builder: (context,model,_){
                return Text(
                  model.index().toString(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<BoxProvider>(context).changeIndex();
        },
        tooltip: 'Increment',
        child: Icon(Icons.change_history),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
