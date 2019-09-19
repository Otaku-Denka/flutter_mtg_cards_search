import 'package:flutter/material.dart';
import 'package:mtg_cards_info/model/scryfall_search_model.dart';
import 'package:mtg_cards_info/widget/search_item.dart';

class SearchItemList extends StatefulWidget {
  final List<ScryfallSearchData> data;
  final handleScrollBtm;
  const SearchItemList({Key key, this.data, this.handleScrollBtm})
      : super(key: key);
  @override
  _SearchItemListState createState() => new _SearchItemListState();
}

class _SearchItemListState extends State<SearchItemList> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.handleScrollBtm();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: widget.data?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        });
  }

  _item(int position) {
    if (widget.data == null) return null;
    ScryfallSearchData item = widget.data[position];
    return SearchItem(
        name: item.name,
        uri: item.uri,
        scryfallUri: item.scryfallUri,
        imageUris: item.imageUris,
        cardFaces: item.cardFaces,
        printedName: item.printedName,
        prices: item.prices);
  }
}
