import 'package:flutter/material.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/constants/colors.dart';
import 'package:konoha/services/api.dart';
import 'package:konoha/constants/configs.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _username;
  final TextEditingController searchText = TextEditingController();
  final FocusNode searchNode = FocusNode();
  List searchResult = [];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: KAppBar(
          title: 'Search',
          leadingIcon: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: searchResult.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Row(
              children: [
                Container(
                  width: media.width * 0.6,
                  child: TextField(
                    controller: searchText,
                    focusNode: searchNode,
                    decoration: InputDecoration(
                      hintText: "User Name",
                      fillColor: inputFieldColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                RaisedButton(
                  elevation: 5.0,
                  color: primaryBlueColor,
                  child: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _username = searchText.text;
                    });
                    searchUser(_username);
                    searchNode.unfocus();
                  },
                ),
              ],
            );
          }
          return InkWell(
            onTap: () {
              print(searchResult[index - 1]);
            },
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      searchResult[index - 1]['imgUrl']
                          .replaceAll('localhost', localhostIp),
                      width: 80.0,
                      height: 80.0,
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      searchResult[index - 1]['name'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> searchUser(String username) async {
    var res = await apiSearchUsers(username);
    setState(() {
      searchResult = res['data'];
    });
  }
}
