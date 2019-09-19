import 'package:flutter/material.dart';
import 'package:mtg_cards_info/model/scryfall_search_model.dart';
import 'package:mtg_cards_info/utils/navigator_util.dart';
import 'package:mtg_cards_info/widget/webview.dart';

class SearchItem extends StatelessWidget {
  final String name;
  final String uri;
  final String scryfallUri;
  final Prices prices;
  final ImageUris imageUris;
  final String printedName;
  final List<CardFaces> cardFaces;

  const SearchItem(
      {Key key,
      this.name,
      this.uri,
      this.scryfallUri,
      this.prices,
      this.cardFaces,
      this.printedName,
      this.imageUris})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String imageUrl;
    if (cardFaces != null && cardFaces.length > 0 && cardFaces[0].imageUris != null && cardFaces[0].imageUris.small != null) {
      imageUrl = cardFaces[0].imageUris.small;
    } else if(imageUris != null && imageUris.small != null){
      imageUrl = imageUris.small;
    } else {
      imageUrl = '';
    }

    return GestureDetector(
        onTap: () {
          NavigatorUtil.push(
              context,
              WebView(
                url: scryfallUri,
                title: printedName != null ? printedName : name,
              ));
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black54))),
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(1, 1, 5, 1),
                    child: Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                    )),
                Column(
                  children: <Widget>[
                    Container(
                        width: 250,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(printedName != null ? printedName : name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black87))),
                    Container(
                        width: 250,
                        child: Text(
                            'Normal: \$${prices?.usd ?? 0}, Foil:\$${prices?.usdFoil ?? 0}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87)))
                  ],
                ),
              ],
            )));
  }
}
