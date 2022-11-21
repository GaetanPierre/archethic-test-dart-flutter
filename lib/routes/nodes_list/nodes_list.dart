import 'dart:async';

import 'package:flutter/material.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

import '../../shared/custom_scaffold.dart';

class NodesListPage extends StatefulWidget {
  const NodesListPage({super.key, required this.title});

  final String title;

  @override
  State<NodesListPage> createState() => _NodesListPageState();
}

class _NodesListPageState extends State<NodesListPage> {
  ApiService coinsService = ApiService("https://mainnet.archethic.net");

  List<Node> _nodeList = List<Node>.empty();

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), _getNodesList);
    super.initState();
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
                'Nodes list (${_nodeList.length}):',
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: _computeListItems(context, _nodeList),
                ),
              ),
            ],
          ),
        ),
        title: 'Archethic nodes list'
        // floatingActionButton: FloatingActionButton(s
        //   onPressed: _search,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future<void> _getNodesList() async {
    coinsService.getNodeList().then(_processNodesList);
  }

  void _processNodesList(List<Node> value) {
    setState(() {
      _nodeList = value;
    });
  }
}

List<ListTile> _computeListItems(BuildContext context, List<Node> value) {
  List<ListTile> list = List.empty(growable: true);
  for (var element in value) {
    list.add(ListTile(
      title: Text(element.ip!),
      onTap: () => _displayDetails(context, element),
    ));
  }

  return list;
}

Future<void> _displayDetails(BuildContext context, Node element) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Node details'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IP : ${element.ip}',
              style: TextStyle(
                  color: ((element.available! && element.authorized!)
                      ? Colors.green
                      : (!element.authorized!)
                          ? Colors.red
                          : Colors.orange),
                  fontWeight: FontWeight.bold),
            ),
            Text('PORT : ${element.port}'),
            Text('Availability : ${element.averageAvailability! * 100}%'),
            Text(
                'Enrolement date : ${DateTime.fromMillisecondsSinceEpoch(element.enrollmentDate! * 1000).toString()}'),
            Text(
                'Authorization date : ${DateTime.fromMillisecondsSinceEpoch(element.authorizationDate! * 1000).toString()}'),
            Text('Reward address : ${element.rewardAddress}'),
            Text('First public key : ${element.firstPublicKey}'),
            Text('Last public key : ${element.lastPublicKey}'),
            Text('Network patch : ${element.networkPatch}'),
            Text('Geo patch : ${element.geoPatch}'),
          ]
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: e,
                ),
              )
              .toList(),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
