import 'package:flutter/material.dart';

class MessageDetailView extends StatefulWidget {
  const MessageDetailView({super.key});

  @override
  State<MessageDetailView> createState() => _MessageDetailViewState();
}

class _MessageDetailViewState extends State<MessageDetailView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Message Detail View'),
      ),
    );
  }
}
