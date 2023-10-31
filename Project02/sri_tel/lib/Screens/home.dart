import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/app_state.dart';
import 'package:sri_tel/models/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Vas>? vas;
  Future<Bill>? bill;
  @override
  void initState() {
    super.initState();
    vas = fetch();
    bill = fetchBill();

    // Your code to run when the widget is loaded
    // For example, you can perform network requests, initialize variables, etc.
  }

  Future<Vas> fetch() async {
    var res = await context.read<AppState>().dio.get('/vas/get/${context.read<AppState>().user!.id}');
    return Vas.fromJson(res.data);
  }

  Future<Bill> fetchBill() async {
    var res = await context.read<AppState>().dio.get('/bill/get/${context.read<AppState>().user!.id}');
    return Bill.fromJson(res.data);
  }

  void apply(Vas v) async {
    try {
      await context.read<AppState>().dio.patch('/vas/update', data: v.toJson());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Success'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      if (e is DioException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.response?.data['message'] ?? 'Error, Try again !'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.read<AppState>().user?.email ?? 'Unkonw'), actions: [
        IconButton(
          onPressed: () => context.read<AppState>().logout(),
          tooltip: 'Logout',
          icon: const Icon(Icons.logout),
          iconSize: 30,
        ),
      ]),
      body: Center(
        child: Consumer<AppState>(
          builder: (context, appState, _) => ListView(
            children: [
              Center(
                child: Text(
                  'Welcome !',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              FutureBuilder(
                future: vas,
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
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                'Telco Services',
                                style: TextStyle(fontSize: 20),
                              )),
                          Card(
                            elevation: 4,
                            child: SwitchListTile(
                              title: const Text('Roaming'),
                              value: snapshot.data!.roaming,
                              onChanged: (value) {
                                setState(() {
                                  snapshot.data!.roaming = value;
                                });
                              },
                            ),
                          ),
                          Card(
                            elevation: 4,
                            child: SwitchListTile(
                              title: const Text('GPRS'),
                              value: snapshot.data!.gprsService,
                              onChanged: (value) {
                                setState(() {
                                  snapshot.data!.gprsService = value;
                                });
                              },
                            ),
                          ),
                          Card(
                            elevation: 4,
                            child: SwitchListTile(
                              title: const Text('Ring In Tone'),
                              value: snapshot.data!.ringInTone,
                              onChanged: (value) {
                                setState(() {
                                  snapshot.data!.ringInTone = value;
                                });
                              },
                            ),
                          ),
                          Card(
                            elevation: 4,
                            child: SwitchListTile(
                              title: const Text('New Alerts'),
                              value: snapshot.data!.newsAlerts,
                              onChanged: (value) {
                                setState(() {
                                  snapshot.data!.newsAlerts = value;
                                });
                              },
                            ),
                          ),
                          Card(
                            elevation: 4,
                            child: SwitchListTile(
                              title: const Text('Sport Updates'),
                              value: snapshot.data!.sportUpdates,
                              onChanged: (value) {
                                setState(() {
                                  snapshot.data!.sportUpdates = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Save'),
                              onPressed: () => apply(snapshot.data!),
                            ),
                          ),
                        ],
                      ),
              ),
              FutureBuilder(
                future: bill,
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
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: const Text(
                                'Account Summary',
                                style: TextStyle(fontSize: 24),
                              )),
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              child: Text(
                                'as ${DateFormat.yMMMEd().format(DateTime.now())}',
                                style: TextStyle(fontSize: 15),
                              )),
                          Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.all(10),
                                        child: const Text(
                                          'Last bill amount',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Rs. ${snapshot.data!.amount.toString()}',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        child: const Text(
                                          'Due Amount      ',
                                          style: TextStyle(fontSize: 20, color: Colors.red),
                                        )),
                                    Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Rs. ${snapshot.data!.dueAmount.toString()}',
                                          style: const TextStyle(fontSize: 20, color: Colors.red),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
