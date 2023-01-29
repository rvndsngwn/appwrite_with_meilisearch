import 'package:flutter/material.dart';
import 'package:meilisearch/meilisearch.dart';

var client = MeiliSearchClient(
  'localhost:7700',
  'MASTER_KEY',
);

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() async {
// An index where books are stored.
    await client.createIndex('books');
    var index = await client.getIndex('books');
    var documents = [
      {'book_id': 123, 'title': 'Pride and Prejudice'},
      {'book_id': 456, 'title': 'Le Petit Prince'},
      {'book_id': 1, 'title': 'Alice In Wonderland'},
      {'book_id': 1344, 'title': 'The Hobbit'},
      {'book_id': 4, 'title': 'Harry Potter and the Half-Blood Prince'},
      {'book_id': 42, 'title': 'The Hitchhiker\'s Guide to the Galaxy'},
      {'book_id': 1000, 'title': 'The Lord of the Rings'},
      {'book_id': 2, 'title': 'The Chronicles of Narnia'},
      {'book_id': 1984, 'title': '1984'},
      {'book_id': 10, 'title': 'Jane Eyre'},
      {'book_id': 16, 'title': 'Wuthering Heights'},
      {'book_id': 3, 'title': 'The Great Gatsby'},
      {'book_id': 100, 'title': 'The Time Machine'},
      {'book_id': 125, 'title': 'A Wrinkle in Time'},
      {'book_id': 1337, 'title': 'The Hunger Games'},
      {'book_id': 1338, 'title': 'T h e H u n g e r G a m e s'},
    ];

// Add documents into index we just created.
    await index.addDocuments(documents);

// Search
    var result = await index.search('prience');
    print(result.hits);
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
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Create Key',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: () async {
                // var key = await client.createKey(
                //   description: 'Key for adding books and testing search',
                //   actions: ["*"],
                //   indexes: ["*"],
                //   expiresAt: DateTime(2042, 04, 02),
                //   uid: "my-key-uid-book",
                // );
                // print(key.toString());
              },
              child: const Text('Create Key'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Index Books',
        child: const Icon(Icons.add),
      ),
    );
  }
}
