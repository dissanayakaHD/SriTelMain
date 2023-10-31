import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/app_state.dart';
import 'package:sri_tel/models/model.dart';

class ChatS extends StatefulWidget {
  const ChatS({super.key});

  @override
  State<ChatS> createState() => _ChatSState();
}

class _ChatSState extends State<ChatS> {
  Future<List<Chat>>? chats;
  TextEditingController ChatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        chats = fetch();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<List<Chat>> fetch() async {
    var res = await context.read<AppState>().dio.get('/chat/user/${context.read<AppState>().user!.id}');
    return (res.data as List<dynamic>).map((cht) => Chat.fromJson(cht as Map<String, dynamic>)).toList();
  }

  void addChat() async {
    await context
        .read<AppState>()
        .dio
        .post('/chat/create', data: {"userId": context.read<AppState>().user!.id, "messageContent": ChatController.text, "state": false});
    ChatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: chats,
        builder: (context, snapshot) => !snapshot.hasData
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading...'),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) => Container(
                        alignment: Alignment.center,
                        padding: snapshot.data![index].isAgent ? const EdgeInsets.fromLTRB(2, 0, 70, 0) : const EdgeInsets.fromLTRB(70, 0, 2, 0),
                        child: Card(
                          color: snapshot.data![index].isAgent ? Colors.cyan[200] : Colors.green[400],
                          child: ListTile(
                            title: Text(
                              snapshot.data![index].messageContent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: ChatController,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            addChat();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
