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

  List<ListTile> _nodesListItems = List<ListTile>.empty();

  @override
  void initState() {
    getNodesList();
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
                  children: _nodesListItems,
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

  void getNodesList() {
    coinsService.getNodeList().then(_processNodesList);
  }

  void _processNodesList(List<Node> value) {
    List<ListTile> items = computeListItems(value);
    setState(() {
      _nodeList = value;
      _nodesListItems = items;
    });
  }
}

List<ListTile> computeListItems(List<Node> value) {
  List<ListTile> list = List.empty(growable: true);
  for (var element in value) {
    print(element.ip!);
    list.add(ListTile(title: Text(element.ip!)));
  }

  return list;
}
