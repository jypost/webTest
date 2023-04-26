import 'package:flutter/material.dart';
import 'package:untitled1/View/TestList.dart';
import 'package:untitled1/View/UserTestWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  MediaQueryData ScreenSize =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window);

  @override
  Widget build(BuildContext context) {
    return Test2();
  }

  Material Test1() {
    return Material(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var screenWidth = constraints.minWidth;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Container(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.red[100],
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.blue[100],
                        alignment: Alignment.center,
                        child: Text('2'),
                      ),
                    ),
                  ],
                ),
              ),
              screenWidth > 900 ?
              Container(
                width: constraints.maxWidth - 800,
                color: Colors.green[100],
                alignment: Alignment.center,
                child: Text('3'),
              )
              :
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green[100],
                  alignment: Alignment.center,
                  child: Text('3'),
                ),
              )
              ,
              screenWidth > 900 ?
              Container(
                  width: 400,
                  color: Colors.yellow[100],
                  alignment: Alignment.center,
                  child: Text('4')
              )
              :
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.yellow[100],
                  alignment: Alignment.center,
                  child: Text('4')
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  }

  Material Test2() {
    return Material(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenWidth = constraints.minWidth;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                Container(
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TestList()
                      ),
                      Expanded(
                        child: UserTest()
                      ),
                    ],
                  ),
                ),
                screenWidth > 900 ?
                Container(
                  width: constraints.maxWidth - 800,
                  color: Colors.green[100],
                  alignment: Alignment.center,
                  child: Text('3'),
                )
                    :
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.green[100],
                    alignment: Alignment.center,
                    child: Text('3'),
                  ),
                )
                ,
                screenWidth > 900 ?
                Container(
                    width: 400,
                    color: Colors.yellow[100],
                    alignment: Alignment.center,
                    child: Text('4')
                )
                    :
                Expanded(
                  flex: 1,
                  child: Container(
                      color: Colors.yellow[100],
                      alignment: Alignment.center,
                      child: Text('4')
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
