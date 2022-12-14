// ignore_for_file: use_build_context_synchronously

import 'package:crud_test/models/user.dart';
import 'package:crud_test/services/user_services.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionContoller = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  final _userService = UserService();

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.user.name ?? '';
      _userContactController.text = widget.user.contact ?? '';
      _userDescriptionContoller.text = widget.user.description ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Crud")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar Novo Usuario',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Entre Seu Nome",
                  labelText: 'Nome',
                  errorText:
                      _validateName ? 'O campo nao pode estar vazio' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userContactController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Entre Seu Contato",
                  labelText: 'Contato',
                  errorText:
                      _validateContact ? 'O campo nao pode estar vazio' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userDescriptionContoller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Coloque a Descri????o",
                  labelText: 'Descri????o',
                  errorText: _validateDescription
                      ? 'O campo nao pode estar vazio'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () async {
                      setState(
                        () {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          //
                          _userContactController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          //
                          _userDescriptionContoller.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        },
                      );
                      if (_validateName == false &&
                          _validateContact == false &&
                          _validateDescription == false) {
                        //print("Seus Dados foram salvos");
                        var _user = User();
                        _user.id = widget.user.id;
                        _user.name = _userNameController.text;
                        _user.contact = _userContactController.text;
                        _user.description = _userDescriptionContoller.text;
                        var result = await _userService.updateUser(_user);
                        Navigator.pop(context, result);
                      }
                    },
                    child: const Text('Atualizar dados'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionContoller.text = '';
                      },
                      child: const Text('Deletar'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
