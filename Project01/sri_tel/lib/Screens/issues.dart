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
  TextEditingController issueController = TextEditingController();

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
    await context
        .read<AppState>()
        .dio
        .post('/issue/create', data: {"userId": context.read<AppState>().user!.id, "messageContent": issueController.text, "state": false});
    issueController.clear();
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
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              snapshot.data![index].messageContent,
                            ),
                            subtitle: snapshot.data![index].state
                                ? const Text(
                                    'Closed',
                                    style: TextStyle(color: Colors.red),
                                  )
                                : const Text(
                                    'Open',
                                    style: TextStyle(color: Colors.green),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: issueController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Open Ticket',
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            snapshot.data!.add(Issue(userId: context.read<AppState>().user!.id!, messageContent: issueController.text));
                          });
                          addIssue();
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ));
  }
}
