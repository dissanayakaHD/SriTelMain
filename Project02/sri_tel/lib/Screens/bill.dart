// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:sri_tel/app_state.dart';
// import 'package:sri_tel/models/model.dart';

// class BillS extends StatefulWidget {
//   const BillS({super.key});

//   @override
//   State<BillS> createState() => _BillSState();
// }

// class _BillSState extends State<BillS> {
//   Future<Bill>? bill;

//   @override
//   void initState() {
//     super.initState();
//     bill = fetch();
//   }

//   Future<Bill> fetch() async {
//     var res = await context.read<AppState>().dio.get('/bill/get/${context.read<AppState>().user!.id}');
//     return Bill.fromJson(res.data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: bill,
//       builder: (context, snapshot) => !snapshot.hasData
//           ? const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 60,
//                     height: 60,
//                     child: CircularProgressIndicator(),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 16),
//                     child: Text('Loading...'),
//                   ),
//                 ],
//               ),
//             )
//           : ListView(
//               children: [
//                 Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     child: const Text(
//                       'Account Status',
//                       style: TextStyle(fontSize: 24),
//                     )),
//                 Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                     child: Text(
//                       'Upto ${DateFormat.yMMMEd().format(DateTime.now())}',
//                       style: TextStyle(fontSize: 15),
//                     )),
//                 Card(
//                     elevation: 4,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(10),
//                                   child: const Text(
//                                     'Bill Value',
//                                     style: TextStyle(fontSize: 20),
//                                   )),
//                               Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(10),
//                                   child: Text(
//                                     'Rs. ${snapshot.data!.amount.toString()}',
//                                     style: TextStyle(fontSize: 20),
//                                   )),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(10),
//                                   child: const Text(
//                                     'Payable Amount',
//                                     style: TextStyle(fontSize: 20),
//                                   )),
//                               Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(10),
//                                   child: Text(
//                                     'Rs. ${snapshot.data!.paybleAmount.toString()}',
//                                     style: const TextStyle(fontSize: 20),
//                                   )),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(10),
//                                   child: const Text(
//                                     'Due Amount',
//                                     style: TextStyle(fontSize: 20, color: Colors.red),
//                                   )),
//                               Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(10),
//                                   child: Text(
//                                     'Rs. ${snapshot.data!.dueAmount.toString()}',
//                                     style: const TextStyle(fontSize: 20, color: Colors.red),
//                                   )),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )),
//               ],
//             ),
//     );
//   }
// }
