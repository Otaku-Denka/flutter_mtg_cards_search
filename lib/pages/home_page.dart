import 'package:flutter/material.dart';
import 'package:mtg_cards_info/dao/scryfall_search_dao.dart';
import 'package:mtg_cards_info/model/scryfall_search_model.dart';
import 'package:mtg_cards_info/widget/search_bar.dart';
import 'package:mtg_cards_info/widget/search_item_list.dart';

const fetchUrl = 'https://api.scryfall.com/cards/search?q=';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScryfallSearchModel searchModel;
  List<ScryfallSearchData> data = [];
  String keyword;
  bool isFetching = false;
  bool isLoadingMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: <Widget>[
          SearchBar(
            hint: '請輸入卡名',
            onChange: _onChange,
          ),
          Expanded(
            child: !isFetching
                ? SearchItemList(data: data,handleScrollBtm:_handleScrollbtm)
                : Center(child: CircularProgressIndicator()),
            flex: 1,
          ),
          Container(
            height: isLoadingMore ? 80 : 0,
            child: isLoadingMore ? Center(child: CircularProgressIndicator()) : Container()
          ) 
        ]));
  }
  _handleScrollbtm(){
    if(searchModel.hasMore && searchModel.nextPage != null && !isLoadingMore){
      setState((){
          isLoadingMore = true;
        });
      ScryfallSearchDao.fetch(searchModel.nextPage, keyword).then((ScryfallSearchModel res) {
        
        if (res.data.length > 0 && res.keyword == keyword ) {
          setState(() {
            searchModel = res;
            isLoadingMore = false;
           data.addAll(res.data);
            
          });
        }
      }).catchError((e) {
        print(e);
        setState((){
          isLoadingMore = false;
        });
      });
    }
  }
  _onChange(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        data = [];
        isFetching = false;
      });
    }
    if (text.length > 0) {
      setState(() {
        isFetching = true;
      });
      //https://api.scryfall.com/cards/search?format=json&include_extras=false&include_multilingual=true&order=name&page=3&q=a+lang%3Aany&unique=cards
      //"$fetchUrl$text+lang%3Aany"
      ScryfallSearchDao.fetch("$fetchUrl$text+lang%3Aany", text).then((ScryfallSearchModel res) {
        if (res.data.length > 0 && res.keyword == keyword) {
          setState(() {
            searchModel = res;
            data = res.data;
            isFetching = false;
            isLoadingMore = false;
          });
        }
      }).catchError((e) {
        print(e);
        setState(() {
          data = [];
          isFetching = false;
          isLoadingMore = false;
        });
      });
    }
  }
}
