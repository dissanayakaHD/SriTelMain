import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/app_state.dart';
import 'package:sri_tel/models/model.dart';

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  Future<List<Issue>>? issue;
  String? issueText;

  @override
  void initState() {
    super.initState();
    issue = fetch();
  }

  Future<List<Issue>> fetch() async {
    var res = await context.read<AppState>().dio.get('/issue/list/${context.read<AppState>().user!.id}');
    return (res.data as List<dynamic>).map((issu) => Issue.fromJson(issu as Map<String, dynamic>)).toList();
  }

  void addIssue() async {
    if (issueText == null) return;
    await context.read<AppState>().dio.post('/issue/create', data: {"userId": context.read<AppState>().user!.id, "messageContent": issueText, "state": false});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: issue,
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
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) => Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data![index].messageContent),
                              snapshot.data![index].state
                                  ? const Text(
                                      'Closed',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : const Text(
                                      'Open',
                                      style: TextStyle(color: Colors.green),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      issueText = await _showTextInputDialog(context);
                      if (issueText != null) {
                        setState(() {
                          snapshot.data!.add(Issue(userId: context.read<AppState>().user!.id!, messageContent: issueText!));
                        });
                      }
                    },
                    child: Text('Open Ticket'),
                  ),
                ],
              ));
  }
}

Future<String?> _showTextInputDialog(BuildContext context) async {
  String inputText = '';

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Open Case'),
        content: TextFormField(
          decoration: InputDecoration(hintText: 'Enter your issue'),
          onChanged: (text) {
            inputText = text;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(inputText);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
