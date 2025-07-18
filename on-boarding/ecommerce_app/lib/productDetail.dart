import 'package:flutter/material.dart';

class Productdetail extends StatelessWidget {
  Productdetail({super.key});

  List<Map<String, dynamic>> product = [
    {
      "image": "images/book2.jpg",
      "title": "The Last Super",
      "price": 23,
      "category": "mens",
      "rating": 4.0,
      "description":
          "Discover the thrilling conclusion to an epic saga with 'The Last Super' - a masterfully crafted novel that combines elements of science fiction, fantasy, and psychological drama. This captivating story follows the journey of Marcus Thompson, a reluctant hero who must navigate through a world where reality and imagination blur together in unexpected ways.\n\nSet in a dystopian future where technology has advanced beyond human comprehension, the narrative explores themes of sacrifice, redemption, and the true meaning of heroism. The author's vivid descriptions transport readers to a realm where every page turn reveals new mysteries and challenges that will keep you on the edge of your seat.\n\nWith over 400 pages of intense storytelling, this book features complex character development, intricate plot twists, and philosophical questions that will resonate with readers long after they've finished the final chapter. The writing style seamlessly blends fast-paced action sequences with moments of deep introspection, creating a reading experience that is both entertaining and thought-provoking.\n\nPerfect for fans of dystopian fiction, science fantasy, and psychological thrillers, 'The Last Super' has received critical acclaim from literary reviewers and has been featured on multiple bestseller lists. Whether you're a seasoned reader of the genre or new to this type of storytelling, this book promises to deliver an unforgettable journey that challenges conventional thinking and explores the depths of human nature.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    height: 300,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        product[0]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product[0]["title"],
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Text("\$${product[0]['price']}"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product[0]["category"],
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Text("${product[0]["rating"]}"),
                ],
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product[0]["description"],
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text(
                      "update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.red),
                    ),
                    onPressed: () {},
                    child: Text("Delete", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
