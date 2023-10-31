import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/app_state.dart';
import 'package:sri_tel/models/model.dart';

class VAS extends StatefulWidget {
  const VAS({super.key});

  @override
  State<VAS> createState() => _VASState();
}

class _VASState extends State<VAS> {
  Future<Vas>? vas;

  @override
  void initState() {
    super.initState();
    vas = fetch();

    // Your code to run when the widget is loaded
    // For example, you can perform network requests, initialize variables, etc.
  }

  Future<Vas> fetch() async {
    var res = await context.read<AppState>().dio.get('/vas/get/${context.read<AppState>().user!.id}');
    return Vas.fromJson(res.data);
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
    return FutureBuilder(
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
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Value Added Services',
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
                    child: const Text('Apply'),
                    onPressed: () => apply(snapshot.data!),
                  ),
                ),
              ],
            ),
    );
  }
}
