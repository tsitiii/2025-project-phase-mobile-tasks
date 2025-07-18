import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: Column(
            children: [
              Text(
                "Hello world",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                  fontSize: 30,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text("Hello my people"),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text("trying to wrap with container"),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.purpleAccent),
                ),
              ),
              Container(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Text("hi tsi"),
                    Container(color: Colors.green, height: 50, width: 50),
                    Container(color: Colors.blue, height: 50, width: 50),
                    Container(color: Colors.orange, height: 50, width: 50),
                    Text("Hi Tad"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}