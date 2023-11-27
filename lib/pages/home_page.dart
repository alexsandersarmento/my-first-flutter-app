
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/components/timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: double.infinity,
        leading: SizedBox(
          width: double.infinity,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Text(
                                'Hello, John Doe',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                              IconButton(
                                splashRadius: 15,
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  print('Edit profile');
                                },
                                icon: const Icon(Icons.expand_more),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Welcome to your timeline',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    print('Settings');
                  },
                  icon: Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Timeline(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
