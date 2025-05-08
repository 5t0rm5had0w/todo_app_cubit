import '../exports.dart';

class PrefUtils {
  static SharedPreferences? _singleton;

  static const _prefTodo = "todo";

  static SharedPreferences? getInstance() {
    return _singleton;
  }

  static Future<bool> initInstance() async {
    _singleton = await SharedPreferences.getInstance();
    return true;
  }

  static List<TodoModel> getTodos() {
    var json = _singleton?.getString(_prefTodo);
    return json == null ? [] : (jsonDecode(json) as List<dynamic>).map((js) => TodoModel.fromJson(js)).toList();
  }

  static Future<bool> setTodo(TodoModel item) async {
    var items = getTodos();

    int index = items.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      items[index] = item;
    } else {
      items.add(item);
    }

    return await _singleton!.setString(_prefTodo, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  static Future<bool> deleteTodo(TodoModel item) async {
    var items = getTodos();

    int index = items.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      items.removeAt(index);
    }

    return await _singleton!.setString(_prefTodo, jsonEncode(items.map((e) => e.toJson()).toList()));
  }
}
