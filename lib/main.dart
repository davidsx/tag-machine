import 'package:flutter/material.dart';
import 'package:tag_machine/tags.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> selectedTags = [];

  toggleTag(tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.removeWhere((element) => element == tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  copyTag() {
    Clipboard.setData(ClipboardData(text: selectedTags.map((tag) => "#$tag").join(" ")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tags Machine")),
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: copyTag,
        child: const Icon(Icons.copy),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...hashTagList
                  .map(
                    (hashTag) => [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          hashTag.title,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SafeArea(
                        child: Wrap(
                          spacing: 8,
                          children: [
                            ...hashTag.tags
                                .map(
                                  (tag) => TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: const BorderSide(color: Colors.transparent),
                                      ),
                                      backgroundColor: selectedTags.contains(tag) ? Colors.blue : Colors.white,
                                      primary: selectedTags.contains(tag) ? Colors.white : Colors.black,
                                    ),
                                    onPressed: () => toggleTag(tag),
                                    child: Text(
                                      '#$tag',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                )
                                .toList()
                          ],
                        ),
                      )
                    ],
                  )
                  .expand((element) => element)
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
