import 'package:crud_test/models/user.dart';
import 'package:flutter/material.dart';

class ViewUser extends StatefulWidget {
  final User user;
  const ViewUser({super.key, required this.user});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Crud "),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Todos os detalhes",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                const Text(
                  'Nome',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    widget.user.name ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                const Text(
                  'Contato',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    widget.user.contact ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Descrição',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.user.description ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
