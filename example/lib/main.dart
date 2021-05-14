import 'package:flutter/material.dart';
import 'package:paulonia_error_service/constants.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';
import 'package:catcher/catcher.dart';

void main() {
  Map<String, CatcherOptions> catcherConf = PauloniaErrorService.getCatcherConfig();
  Catcher(
    rootWidget: MyApp(),
    debugConfig: catcherConf[CatcherConfig.DEBUG],
    profileConfig: catcherConf[CatcherConfig.PROFILE],
    releaseConfig: catcherConf[CatcherConfig.RELEASE],
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Paulonia Error Service'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Press this button to generate an error:',
            ),
            MaterialButton(
              child: Text('Error!!'),
              onPressed: (){
                PauloniaErrorService.sendErrorWithoutStacktrace("This is an error");
              },
            ),
            MaterialButton(
              child: Text('Error 2!!'),
              onPressed: (){
                divide();
              },
            ),
          ],
        ),
      ),
    );
  }

  double divide(){
    try{
      return 10 / null;
    }
    catch(error, stacktrace){
      PauloniaErrorService.sendError(error, stacktrace);
      return 0;
    }

  }

}
