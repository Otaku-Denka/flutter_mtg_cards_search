import 'dart:async';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final onChange;
  final String hint;

  const SearchBar({Key key, this.onChange, this.hint}) : super(key: key);
  @override
  _SearchBarState createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool showClear = false;
  

  
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[_inputBox()],
        ));
  }

  Widget _inputBox() {
    return Container(
        height: 30,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1.0)),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              size: 20,
              color: Colors.brown,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                  controller: _controller,
                  onSubmitted: (String str){
                    if (widget.onChange != null) {
                      widget.onChange(str);
                    }
                  },
                  onChanged: (String text) {
                    _onChange();
                  },
                  autofocus: true,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    border: InputBorder.none,
                    hintText: widget.hint ?? 'Search...',
                    hintStyle: TextStyle(fontSize: 15),
                  )),
            ),
            if (showClear)
              _wrapTap(
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.white,
                  ), () {
                setState(() {
                  _controller.clear();
                });
                _onChange();
              })
          ],
        ));
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  _onChange() {
    
    if (_controller.text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
  }
}
