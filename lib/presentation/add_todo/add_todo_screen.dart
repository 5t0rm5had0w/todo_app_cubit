import '../../exports.dart';

class AddTodoScreen extends StatefulWidget {
  final TodoModel? itemTodo;

  const AddTodoScreen({super.key, this.itemTodo});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var todo = widget.itemTodo;
    if (todo != null) {
      _todoController.text = todo.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state.status.isSuccess && state.todoType == EnumTodoType.add) {
          Navigator.pop(context);
        }
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                8.height,
                Text(
                  "New todo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                8.height,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.grey.shade200,
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter...",
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                8.height,
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey.shade300,
                          ),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    4.width,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String td = _todoController.text;
                          if (td.isEmpty) {
                            Fluttertoast.showToast(msg: "Write todo!!!", backgroundColor: Colors.orange);
                            return;
                          }
                          if (widget.itemTodo != null) {
                            context.read<TodoCubit>().editTodo(widget.itemTodo!.copyWith(name: td));
                          } else {
                            context.read<TodoCubit>().addTodo(td);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: colorPrimary,
                          ),
                          child: Text(
                            widget.itemTodo != null ? "Edit" : "Save",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                8.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
