import 'package:flutter/material.dart';
import 'package:nsd/nsd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter NSD Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter NSD Demo'),
    
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _connection = true;

  late Registration registration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      registration =
          await register(const Service(name: "nsd_local", type: '_http._tcp', port: 56000));
    });
  }

  @override
  void dispose() {
    unregister(registration);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Push the Button to unregister',
            ),
          ],
        ),
      ),
      floatingActionButton: !_connection
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await unregister(registration);
                setState(() {
                  _connection = false;
                });
              },
              tooltip: 'Disconnect',
              child: const Icon(Icons.private_connectivity),
            ),
    );
  }
}
