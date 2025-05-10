import '../exports.dart';

class TodoItemView extends StatefulWidget {
  final TodoModel todoModel;
  final int index;

  const TodoItemView({super.key, required this.todoModel, required this.index});

  @override
  State<TodoItemView> createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _scaleAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 70),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallCard = MediaQuery.of(context).size.width < 400;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      // onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              padding: EdgeInsets.all(isSmallCard ? 10 : 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
                gradient: LinearGradient(
                  colors: getRandomColor(widget.index),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: getRandomColor(widget.index)[0].withOpacity(0.3),
                    blurRadius: _isPressed ? 8 : 16,
                    offset: _isPressed ? const Offset(0, 2) : const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<TodoCubit>().checkTodo(widget.todoModel, !widget.todoModel.isDone);
                    },
                    icon: Icon(
                      widget.todoModel.isDone ? IconsaxBold.tick_circle : IconsaxOutline.record,
                      color: Colors.white,
                    ),
                  ),
                  4.width,
                  Expanded(
                    child: Text(
                      widget.todoModel.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _addTodoDialog(context, widget.todoModel);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      confirmGeneralDialog(context, "Delete", subTitle: "Are you sure you want to delete this todo?",
                          pressOk: () {
                        context.read<TodoCubit>().deleteTodo(widget.todoModel);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addTodoDialog(BuildContext context, TodoModel item) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AddTodoScreen(
          itemTodo: item,
        );
      },
    );
  }
}
