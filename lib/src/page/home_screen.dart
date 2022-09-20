import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_maker/src/conponent/dot_picture.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Edit'),
                onPressed: () {
                  context.push('/edit');
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  child: const Text('Settings')),
              Expanded(
                child: FirestoreListView(
                  query: FirebaseFirestore.instance.collection('image'),
                  itemBuilder: (context, doc) {
                    final data = doc.data();
                    final createdAt = (data['createdAt'] as Timestamp).toDate();
                    final updatedAt = (data['updatedAt'] as Timestamp).toDate();
                    final size = data['size'] as int;
                    final linerImage = data['pixels'] as List;
                    return Row(
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: DotPicture(
                              size: size,
                              pixels: [
                                for (int i = 0; i < size; i++)
                                  [
                                    for (int j = 0; j < size; j++)
                                      Color(linerImage[i * size + j])
                                  ],
                              ],
                              border: false),
                        ),
                        Column(
                          children: [
                            Text('creator:${data['creator']}'),
                            Text('size:${data['size']}'),
                            Text(
                                'created at:${createdAt.month}/${createdAt.day} ${createdAt.hour}:${createdAt.minute}'),
                            Text(
                                'updated at:${updatedAt.month}/${updatedAt.day} ${updatedAt.hour}:${updatedAt.minute}'),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
