import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/repogitory/user_model.dart';
import 'package:untitled1/repogitory/user_provider.dart';

class UserTest extends StatefulWidget {
  UserTest({super.key});

  @override
  State<UserTest> createState() => _UserTestState();
}

class _UserTestState extends State<UserTest> {
  var user = User(responseResult: 0, responseMessage: '');
  TextEditingController _textEditingController = TextEditingController(text: '닉네임');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.microtask(() async {
    Future.delayed(Duration(milliseconds: 100), () async {
      user = await Provider.of<UserProvider>(context, listen: false).makeRequest(
          'test1@test.com', 'test12');
    });
  }

  @override
  Widget build(BuildContext context) {
    var userP = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Model data Test'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('${user.responseMessage}'),
            TextFormField(
              controller: _textEditingController,
            ),

          ],
        ),
      ),
    );
  }
}
