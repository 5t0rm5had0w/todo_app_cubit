import '../../../exports.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState());

  void getAllTodos() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    var todos = PrefUtils.getTodos();
    emit(state.copyWith(status: FormzSubmissionStatus.success, todos: todos, todoType: EnumTodoType.list));
  }

  void addTodo(String todo) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    await PrefUtils.setTodo(TodoModel(DateTime.now().millisecondsSinceEpoch ~/ 1000, todo));
    var todos = PrefUtils.getTodos();
    emit(state.copyWith(status: FormzSubmissionStatus.success, todoType: EnumTodoType.add, todos: todos));
  }

  void checkTodo(TodoModel todoModel, bool check) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    todoModel.isDone = check;
    await PrefUtils.setTodo(todoModel);
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  void deleteTodo(TodoModel todoModel) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    await PrefUtils.deleteTodo(todoModel);
    var todos = PrefUtils.getTodos();
    emit(state.copyWith(status: FormzSubmissionStatus.success, todos: todos));
  }
}
