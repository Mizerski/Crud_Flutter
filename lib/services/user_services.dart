import 'package:crud_test/db_helper/repository.dart';

import '../models/user.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  //Salvar Usario
  saveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  //Ler Todos usarios
  readAllUsers() async {
    return await _repository.readData('users');
  }

  //Editar usario
  updateUser(User user) async {
    return await _repository.updateData('users', user.userMap());
  }

  //Deletar usario
  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}
