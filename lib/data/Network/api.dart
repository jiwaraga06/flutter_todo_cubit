String baseUrl = "http://192.168.50.6:8000";

class Api {
  static getTodo() {
    return '$baseUrl/api/todo';
  }

  static addTodo() {
    return '$baseUrl/api/addTodo';
  }

  static updateTodo() {
    return '$baseUrl/api/updateTodo';
  }
  static register() {
    return '$baseUrl/api/register';
  }
}
