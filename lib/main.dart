import 'package:app/base_url_client.dart';
import 'package:app/proto/helloworld/v1/greeter.client.dart';
import 'package:app/proto/helloworld/v1/greeter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kratos_plugin/kratos_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  void initState() {
    _client = BaseUrlClient(http.Client(), Uri.parse('http://127.0.0.1:8000'));
    _greeter = GreeterClientImpl(_client);
    _controller = TextEditingController();
    super.initState();
  }

  late http.Client _client;

  late GreeterClient _greeter;

  late TextEditingController _controller;

  String? _message;

  bool processing = false;

  Future<void> _sendMessage() async {
    if (processing) {
      throw '重复调用';
    }
    setState(() {
      processing = true;
    });

    try {
      final reply = await _greeter.sayHello(
        HelloRequest(name: _controller.text),
      );
      setState(() {
        _message = 'success: ${reply.message}';
      });
    } on KratosError catch (e) {
      setState(() {
        _message = 'kratos error: ${e.reason} ${e.message}';
      });
    } catch (e) {
      setState(() {
        _message = 'error: $e';
      });
    } finally {
      setState(() {
        processing = false;
      });
    }
  }

  @override
  void dispose() {
    _client.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _message = this._message;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              onEditingComplete: _sendMessage,
              textInputAction: TextInputAction.search,
              autofocus: true,
              enabled: !processing,
            ),
            if (_message != null) Text(_message),
          ],
        ),
      ),
    );
  }
}
