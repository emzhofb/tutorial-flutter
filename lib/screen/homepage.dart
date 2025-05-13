import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  final List<String> quotes = const [
    "The only way to do great work is to love what you do. — Steve Jobs",
    "Success is not the key to happiness. Happiness is the key to success.",
    "Believe you can and you're halfway there. — Theodore Roosevelt",
    "Don’t watch the clock; do what it does. Keep going. — Sam Levenson",
    "Success usually comes to those who are too busy to be looking for it. — Henry David Thoreau",
    "The future belongs to those who believe in the beauty of their dreams. — Eleanor Roosevelt",
    "Your time is limited, so don’t waste it living someone else’s life. — Steve Jobs",
    "The way to get started is to quit talking and begin doing. — Walt Disney",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👇 Section 1: Carousel Slider
            const Text(
              "🔥 Carousel Slider",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items:
                  quotes.map((quote) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            quote,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),

            // 👇 Section 2: Grid View
            const Text(
              "🔷 Grid View",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              itemCount: quotes.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        quotes[index],
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // 👇 Section 3: Wrap Layout
            const Text(
              "📌 Wrap Layout",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  quotes.map((quote) {
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          quote,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),

            // 👇 Section 4: List View
            const Text(
              "📜 List View",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: quotes.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.format_quote),
                    title: Text(
                      quotes[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
