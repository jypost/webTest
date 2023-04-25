import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  int _limit = 10;

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoading || !_hasMore) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 3)); // 2초 지연

    final response = await http.get(
      // Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$_currentPage&_limit=20'),
      Uri.parse('http://localhost:8000/postlist/?page=$_currentPage&limit=$_limit'),
    );
    print('요청');
    print('_currentPage $_currentPage');

    if (response.statusCode == 200) {
      // List<Map<String, dynamic>> newItems = jsonDecode(response.body);

      dynamic result = utf8.decode(response.bodyBytes);
      // var data = json.decode(result);
      // List<dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonResponse = jsonDecode(result);
      List<Map<String, dynamic>> newItems =
          List<Map<String, dynamic>>.from(jsonResponse);

      setState(() {
        _items.addAll(newItems);
        _isLoading = false;
        _currentPage++;
      });

      // if (newItems.isEmpty) {
      if (newItems.isEmpty || newItems.length < _limit) { // 수정
        setState(() {
          _hasMore = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
      // return [];
    }


    print('_hasMore $_hasMore');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scroll ListView'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length + (_hasMore ? 1 : 0),
        // itemCount: _items.length,
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return _buildLoader();
          } else {
            return ListTile(
              title: Text(_items[index]['title']),
              subtitle: Text(_items[index]['content']),
              leading: Text(_items[index]['post_id'].toString()),
              trailing: Text(_items[index]['author'].toString()),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoader() {
    return _isLoading
        ? Container(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _hasMore
            ? Container()
            : Container(
                height: 50,
                width: 400,
                child: Center(
                  child: Text('마지막 데이터입니다.'),
                ),
              );
  }
}

// import 'package:flutter/material.dart';
//
// class TestList extends StatefulWidget {
//   @override
//   _TestListState createState() => _TestListState();
// }
//
// class _TestListState extends State<TestList> {
//   ScrollController _scrollController = ScrollController();
//   List<String> _items = [];
//   bool _isLoading = false;
//   bool _hasMore = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMoreItems();
//     _scrollController.addListener(_scrollListener);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _scrollListener() {
//     if (_scrollController.offset >=
//         _scrollController.position.maxScrollExtent &&
//         !_scrollController.position.outOfRange) {
//       _loadMoreItems();
//     }
//   }
//
//   Future<void> _loadMoreItems() async {
//     if (_isLoading || !_hasMore) {
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     // API로부터 데이터를 가져옵니다. 예시 코드에서는 단순히 더미 데이터를 생성합니다.
//     List<String> newItems = List.generate(20, (index) => "Item ${_items.length + index + 1}");
//
//     await Future.delayed(Duration(seconds: 1)); // API 요청 딜레이 시뮬레이션
//
//     if (newItems.isEmpty) {
//       setState(() {
//         _hasMore = false;
//       });
//     } else {
//       setState(() {
//         _items.addAll(newItems);
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Infinite Scroll ListView'),
//       ),
//       body: ListView.builder(
//         controller: _scrollController,
//         itemCount: _items.length + (_hasMore ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == _items.length) {
//             return _buildLoader();
//           } else {
//             return ListTile(
//               title: Text(_items[index]),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildLoader() {
//     return _isLoading
//         ? Container(
//       height: 50,
//       child: Center(
//         child: CircularProgressIndicator(),
//       ),
//     )
//         : _hasMore
//         ? Container()
//         : Container(
//       height: 50,
//       child: Center(
//         child: Text('마지막 데이터입니다.'),
//       ),
//     );
//   }
// }
