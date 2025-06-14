import 'package:flutter/material.dart';
import 'package:mini_todo/constants/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('About'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
                padding: EdgeInsets.all(20),
                child: Column(

                  children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/todo-logo.png",
                                fit: BoxFit.contain,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'A simple and elegant To-Do app to help you stay organized and productive.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 50),

                        const ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Developed by'),
                          subtitle: Text('CodingBloom', style: TextStyle(color: Colors.grey),),
                        ),

                        const ListTile(
                          leading: Icon(Icons.email),
                          title: Text('Contact'),
                          subtitle: Text('support@codingbloom.com', style: TextStyle(color: Colors.grey),),
                        ),

                        const ListTile(
                          leading: Icon(Icons.link),
                          title: Text('Website'),
                          subtitle: Text('https://codingbloom.com', style: TextStyle(color: Colors.grey),),
                        ),

                        const SizedBox(height: 40),
                  ],
                ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  final version = snapshot.data?.version;
                  if (version == null) return const SizedBox();

                  return Text(
                    'App Version: $version',
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
      )

    );
  }
}
