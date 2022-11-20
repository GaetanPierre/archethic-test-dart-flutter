import 'package:flutter/material.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

import '../../shared/custom_scaffold.dart';

class TokenPricePage extends StatefulWidget {
  const TokenPricePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TokenPricePage> createState() => _TokenPricePageState();
}

class _TokenPricePageState extends State<TokenPricePage> {
  static const List<String> currencyList = <String>['BTC', 'EUR', 'USD', 'GBP'];
  String dropdownValue = currencyList.first;
  SimplePriceResponse? _lastPrice;
  String currency = "BTC";

  ApiCoinsService coinsService = ApiCoinsService();

  @override
  void initState() {
    super.initState();
    _search(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _search method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return CustomScaffold(
     
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Testing some API of Archethic\'s coins service',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Text('Select currency :'),
            DropdownButton<String>(
              items: currencyList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: dropdownValue,
              onChanged: _onCurrencyChanged,
              icon: const Icon(Icons.arrow_drop_down),
              
            ),
            Text(
              'Last UCO/${_lastPrice?.currency} price:',
            ),
            Text(
              '${_lastPrice?.localCurrencyPrice}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      title: 'UCO price'
      // floatingActionButton: FloatingActionButton(s
      //   onPressed: _search,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _processSimplePrice(SimplePriceResponse value) {
    setState(() {
      _lastPrice = value;
    });
  }

  void _onCurrencyChanged(String? value) {
    _search(value);
  }

  void _search(String? currency) {
    
    setState(() {
        dropdownValue = currency!;
      });

    if (currency != null && currency.isNotEmpty) {
      coinsService.getSimplePrice(currency).then(_processSimplePrice);
    }
  }
}