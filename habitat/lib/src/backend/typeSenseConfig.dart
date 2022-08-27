import 'dart:io';

import 'package:typesense/typesense.dart';

class TypeSenseInstance {
  static final TypeSenseInstance _control = TypeSenseInstance._internal();

  late Client client;

  factory TypeSenseInstance() {
    return _control;
  }

  TypeSenseInstance._internal() {
    configura();
  }

  void configura() async {
    final host = InternetAddress.loopbackIPv4.address, protocol = Protocol.http;
    final config = Configuration(
      'WauT78cGIadfNvK8odHEj4ZbMtzQdimc', // apiKey
      nodes: {
        Node(
          Protocol.https,
          'ou4inezmag73hs8rp-1.a1.typesense.net', // host
          port: 443,
        ),
        // Node.withUri(
        //   Uri(
        //     scheme: 'http',
        //     host: 'ou4inezmag73hs8rp-1.a1.typesense.net',
        //     port: 443,
        //   ),
        // ),
      },
      numRetries: 5, // A total of 4 tries (1 original try + 3 retries)
      connectionTimeout: const Duration(seconds: 20),
    );

    client = Client(config);

    // print(await client.collections.retrieve());
  }
}
