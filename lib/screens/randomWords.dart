import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget{
  @override
  _RandomWordsState createState()=> _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords>{
  final List<WordPair> _suggestions = <WordPair>[];
  final Set _saved =Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize:18);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions:[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(label: 'Startup Namer', icon: Icon(Icons.home), backgroundColor: Colors.blue,),
          BottomNavigationBarItem(label: 'Fuel Cost', icon: Icon(Icons.add_to_queue), backgroundColor: Colors.blue,),
          BottomNavigationBarItem(label: 'Todo List', icon: Icon(Icons.add_to_queue), backgroundColor: Colors.blue,),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if(i.isEven){
          return Divider();
        }
        final int index = i~/2;

        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
          pair.asPascalCase,
          style:_biggerFont
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder:(BuildContext context){
              final tiles = _saved.map((pair) {
                return ListTile(title: Text(pair.asPascalCase, style: _biggerFont));
              });
              final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList();
              return Scaffold(
                appBar: AppBar(
                  title: Text('Saved Suggestions'),
                ),
                body: ListView(children: divided),
              );
            }
        )
    );
  }



}