import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imagelist = [
    'images/book2.jpg',
    'images/cute.jpg',
    'images/ear.jpg',
    'images/google.png',
    'images/green.jpg',
    'images/gumball.jpg',
    'images/harry.jpg',
    'images/home.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              reverse: true,
              physics: BouncingScrollPhysics(),
              cacheExtent: 500,
              childAspectRatio: 0.8,
              scrollDirection: Axis.vertical,
              children: [
                mybox(1),
                mybox(2),
                mybox(3),
                mybox(4),
                mybox(5),
                mybox(6),
                mybox(7),
                mybox(8),
                mybox(9),
                mybox(10),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: imagelist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: Image.asset(imagelist[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget mybox(int index) {
  return Container(
    margin: const EdgeInsets.all(8),
    color: Colors.blue,
    alignment: Alignment.center,
    child: Text("$index"),
  );
}
