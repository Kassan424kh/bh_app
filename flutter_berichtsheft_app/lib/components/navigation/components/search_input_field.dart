import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class SearchInputField extends StatefulWidget {
  final onTap;
  final onSubmitted;

  SearchInputField({
    Key key,
    this.onTap,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  API _api;

  @override
  void initState() {
    super.initState();
    setState(() {
      _api = API(context: context);
    });
  }


  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      color: (_selectedTheme[ElementStylingParameters.headerTextColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.splashOpacity]),
      child: TextField(
        style: TextStyle(color: _selectedTheme[ElementStylingParameters.headerTextColor]),
        onTap: widget.onTap,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor]),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          fillColor: _selectedTheme[ElementStylingParameters.primaryColor],
          icon: Container(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.search,
              color: _selectedTheme[ElementStylingParameters.headerTextColor],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
