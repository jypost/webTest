import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/repogitory/user_model.dart';

class UserProvider extends ChangeNotifier {

  late User user;
  bool _isLoading = false;
  bool _hasMore = false;

  //makeRequest
  makeRequest(email, password) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/login/'), body: <String, String>{
      "email": "$email",
      "password": "$password"
    });
    dynamic result = utf8.decode(response.bodyBytes);
    final decodedUser = User.fromJson(jsonDecode(result));
    print('decodedUser :? ${decodedUser.responseMessage}');
    user = decodedUser;
    return decodedUser;
  }
  //fetch
  fetchUserCash(email, password) async {
    user = await makeRequest(email, password);
    notifyListeners();
  }


  // Future<void> _loadMoreItems(_currentPage, _limit) async {
  //   if (_isLoading || !_hasMore) {
  //     return;
  //   }
  //
  //   _isLoading = true;
  //
  //   // setState(() {
  //   //   _isLoading = true;
  //   // });
  //
  //   notifyListeners();
  //
  //   await Future.delayed(Duration(milliseconds: 3)); // 2초 지연
  //
  //   final response = await http.get(
  //     // Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$_currentPage&_limit=20'),
  //     // Uri.parse('http://localhost:8000/postlist/?page=$_currentPage&limit=$_limit'),
  //     Uri.parse('http://127.0.0.1:8000/login/'),
  //   );
  //   print('요청');
  //   print('_currentPage $_currentPage');
  //
  //   if (response.statusCode == 200) {
  //     // List<Map<String, dynamic>> newItems = jsonDecode(response.body);
  //
  //     dynamic result = utf8.decode(response.bodyBytes);
  //     // var data = json.decode(result);
  //     // List<dynamic> jsonResponse = jsonDecode(response.body);
  //     List<dynamic> jsonResponse = jsonDecode(result);
  //     List<Map<String, dynamic>> newItems =
  //     List<Map<String, dynamic>>.from(jsonResponse);
  //
  //     setState(() {
  //       _items.addAll(newItems);
  //       _isLoading = false;
  //       _currentPage++;
  //     });
  //
  //     // if (newItems.isEmpty) {
  //     if (newItems.isEmpty || newItems.length < _limit) { // 수정
  //       setState(() {
  //         _hasMore = false;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     throw Exception('Failed to load data');
  //     // return [];
  //   }
  //
  //
  //   print('_hasMore $_hasMore');
  // }

}

//
// 코드팩토리 참고
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class AjaxProvider extends ChangeNotifier {
//   List<int> cache = [];
//
//   // 로딩
//   bool loading = false;
//   // 아이템이 더 있는지
//   bool hasMore = true;
//
//   _makeRequest({
//     @required int nextId,
//   }) async {
//     assert(nextId != null);
//
//     await Future.delayed(Duration(seconds: 1));
//
//     // Item 은 nextId 가 99 까지만 있음
//     if(nextId == 100){
//       return [];
//     }
//
//     //nextId 다음의 20개의 값을 리스트로 리턴
//     return List.generate(20, (index) => nextId + index);
//   }
//
//   fetchItems({
//     int nextId,
//   }) async {
//     nextId ??= 0;
//
//     loading = true;
//
//     notifyListeners();
//
//     final items = await _makeRequest(nextId: nextId);
//
//     this.cache = [
//       ...this.cache,
//       ...items,
//     ];
//
//     if(items.length == 0){
//       hasMore = false;
//     }
//
//     loading = false;
//
//     notifyListeners();
//   }
// }