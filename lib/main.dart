// ignore_for_file: use_build_context_synchronously

import 'package:crud_test/models/user.dart';
import 'package:crud_test/screens/add_users.dart';
import 'package:crud_test/screens/edit_user.dart';
import 'package:crud_test/screens/view_user.dart';
import 'package:crud_test/services/user_services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Crud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<User> _userList = <User>[];
  final _userServices = UserService();

  getAllUserDetails() async {
    var users = await _userServices.readAllUsers();
    _userList = <User>[];

    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text(
            'Voce tem certeza que deseja deletar?',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                var result = await _userServices.deleteUser(userId);
                if (result != null) {
                  Navigator.pop(context);
                  getAllUserDetails();
                  _showSuccessSnackBar('Usario deletado com sucesso');
                }
              },
              child: const Text('Deletar'),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fechar'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Crud")),
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewUser(
                              user: _userList[index],
                            )));
              },
              leading: const Icon(Icons.person),
              title: Text(_userList[index].name ?? ''),
              subtitle: Text(_userList[index].contact ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUser(
                            user: _userList[index],
                          ),
                        ),
                      ).then(
                        (data) {
                          if (data != null) {
                            getAllUserDetails();
                            _showSuccessSnackBar(
                              'Usario atualizado com sucesso',
                            );
                          }
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.teal,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteFormDialog(context, _userList[index].id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUser(),
            ),
          ).then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('Contato adicionado com sucesso');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
