import '../../../exports.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<GetTodoEvent>(_getTodos);
    on<AddTodoEvent>(_addTodo);
    on<CheckTodoEvent>(_checkTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<EditTodoEvent>(_editTodo);
  }

  void _getTodos(GetTodoEvent event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    var todos = PrefUtils.getTodos();
    emit(state.copyWith(status: FormzSubmissionStatus.success, todos: todos, todoType: EnumTodoType.list));
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    await PrefUtils.setTodo(TodoModel(DateTime.now().millisecondsSinceEpoch ~/ 1000, event.todoName));
    var todos = PrefUtils.getTodos();
    emit(state.copyWith(status: FormzSubmissionStatus.success, todoType: EnumTodoType.add, todos: todos));
  }

  void _checkTodo(CheckTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    event.todoModel.isDone = event.check;
    await PrefUtils.setTodo(event.todoModel);
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    await PrefUtils.deleteTodo(event.todoModel);
    var todos = PrefUtils.getTodos();
    emit(state.copyWith(status: FormzSubmissionStatus.success, todos: todos));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial, todoType: EnumTodoType.none));
    await PrefUtils.setTodo(event.todoModel);
    var todos = PrefUtils.getTodos();
    emit(state.copyWith(status: FormzSubmissionStatus.success, todoType: EnumTodoType.add, todos: todos));
  }

  int get allTodosLenth => state.todos.length;

  int get finishTodosLenth => state.todos.where((e) => e.isDone == true).length;

  int get unFinishTodosLenth => state.todos.where((e) => e.isDone == false).length;

  double get todosFinishPercent {
    var todos = state.todos;
    if (todos.isEmpty) return 0.0;
    return finishTodosLenth / allTodosLenth;
  }
}
