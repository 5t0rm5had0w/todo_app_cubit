import '../exports.dart';

class TodoItemView extends StatelessWidget {
  final TodoModel todoModel;
  final int number;

  const TodoItemView({super.key, required this.todoModel, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "$number. ${todoModel.name}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Checkbox(
                value: todoModel.isDone,
                onChanged: (check) {
                  context.read<TodoCubit>().checkTodo(todoModel, (check ?? false));
                },
              ),
              IconButton(
                  onPressed: () {
                    context.read<TodoCubit>().deleteTodo(todoModel);
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
