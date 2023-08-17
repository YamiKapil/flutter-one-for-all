import 'dart:isolate';

import 'package:flutter/foundation.dart';

// example One of isolate
void main(List<String> args) async {
  await for (final msg in getMessage().take(10)) {
    if (kDebugMode) {
      print(msg);
    }
  }
}

Stream<String> getMessage() async* {
  final rp = ReceivePort();
  // simple way.....
  // make the function async and await the isolate spawn...
  await Isolate.spawn(_getMessage, rp.sendPort);
  await for (final msg
      in rp.takeWhile((element) => element is String).cast<String>()) {
    yield msg;
  }
}

// Stream<String> getMessage() {
// final rp = ReceivePort();
// return Isolate.spawn(_getMessage, rp.sendPort)
//     .asStream()
//     .asyncExpand((_) => rp)
//     .takeWhile((element) => element is String)
//     .cast();
// }

// creating function that is able to produce some message
void _getMessage(SendPort sp) async {
  await for (final date in Stream.periodic(
    const Duration(milliseconds: 200),
    (_) => DateTime.now().toIso8601String(),
  )) {
    sp.send(date);
  }
}

// Example Two for isolate
//............................................................

// void main(List<String> args) async {
//   do {
//     stdout.write('Say Somethind:');
//     final line = stdin.readLineSync(encoding: utf8);
//     switch (line?.trim().toLowerCase()) {
//       case null:
//         continue;
//       case 'exit':
//         exit(0);
//       default:
//         final msg = await getMessage(line!);
//         print(msg);
//     }
//   } while (true);
// }

// Future<String> getMessage(String userText) async {
//   final rp = ReceivePort();
//   Isolate.spawn(
//     _communicator,
//     rp.sendPort,
//   );
//   final broadcastRp = rp.asBroadcastStream();
//   final SendPort communicatorSendPort = await broadcastRp.first;
//   communicatorSendPort.send(userText);
//   return broadcastRp
//       .takeWhile((element) => element is String)
//       .cast<String>()
//       .take(1)
//       .first;
// }

// void _communicator(SendPort sp) async {
//   final rp = ReceivePort();
//   sp.send(rp.sendPort);
//   final messages = rp.takeWhile((element) => element is String).cast<String>();
//   await for (final message in messages) {
//     for (final entry in messagesAndResponses.entries) {
//       if (entry.key.trim().toLowerCase() == message.trim().toLowerCase()) {
//         sp.send(entry.value);
//         continue;
//       }
//     }
//     // commented for example 3.... used in example 2
//     // sp.send('I have no response to that!!');
//   }
// }

// const messagesAndResponses = {
//   '': 'Ask me a question like "How are you?"',
//   'Hello': 'Hi',
//   'How are you?': 'Fine',
//   'What are you doing?': 'Chilling',
//   'Are you having fun?': 'I guess!',
// };

// Example Three
// Keeping Isolate Alive so we can communicate with it when we like
// ................................................................

// void main(List<String> args) async {
//   final responder = await Responder.create();
//   do {
//     stdout.write('Say Something(or type exit):');
//     final line = stdin.readLineSync(encoding: utf8);
//     switch (line?.trim().toLowerCase()) {
//       case null:
//         continue;
//       case 'exit':
//         exit(0);
//       default:
//         final msg = await responder.getMessage(line!);
//         print(msg);
//     }
//   } while (true);
// }

// for keeping isolate alive
// class Responder {
//   final ReceivePort rp;
//   final Stream<dynamic> broadcastRp;
//   final SendPort communicatorSendPort;

//   Responder({
//     required this.rp,
//     required this.broadcastRp,
//     required this.communicatorSendPort,
//   });

//   // dart doesnot let us create async Constructor
//   // so we create a async function as a way around..
//   static Future<Responder> create() async {
//     final rp = ReceivePort();
//     Isolate.spawn(_communicator, rp.sendPort);
//     // convert receive port to broadcast stream
//     final broadcastRp = rp.asBroadcastStream();
//     // awiat on the first messge on the broadcase stream
//     final SendPort communicatorSendPort = await broadcastRp.first;
//     // returning the instance of the Responder
//     return Responder(
//       rp: rp,
//       broadcastRp: broadcastRp,
//       communicatorSendPort: communicatorSendPort,
//     );
//   }

//   Future<String> getMessage(String userText) async {
//     communicatorSendPort.send(userText);
//     return broadcastRp
//         .takeWhile((element) => element is String)
//         .cast<String>()
//         .take(1)
//         .first;
//   }
// }

/// Example four json downloading and parsing using Isolate..
//..............................................................

// void main(List<String> args) async {
//   final rp = ReceivePort();
//   Isolate.spawn(
//     _parseJsonIsolateEntry,
//     rp.sendPort,
//   );
//   final todos = rp
//       .takeWhile((element) => element is Iterable<Todo>)
//       .cast<Iterable<Todo>>()
//       .take(1);
//   await for (final todo in todos) {
//     print(todo);
//   }
// }

// void _parseJsonIsolateEntry(SendPort sp) async {
//   final client = HttpClient();
//   final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');

//   final todo = await client
//       .getUrl(uri)
//       .then((value) => value.close())
//       .then((value) => value.transform(utf8.decoder).join())
//       .then((value) => jsonDecode(value) as List<dynamic>)
//       .then((value) => value.map((e) => Todo.fromJson(e)));
//   sp.send(todo);
// }

// class Todo {
//   final int userId;
//   final int id;
//   final String title;
//   final bool isCompleted;

//   Todo({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.isCompleted,
//   });

//   Todo.fromJson(Map<String, dynamic> json)
//       : userId = json['userId'],
//         id = json['id'],
//         title = json['title'],
//         isCompleted = json['completed'];
// }


// Example 5
// Spawn Isolate from inside a library

