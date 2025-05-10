import '../../exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(GetWeatherEvent());
    // context.read<TodoCubit>().getAllTodos();
    context.read<TodoBloc>().add(GetTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(state.errorMessage),
                ),
              );
            }
          },
        ),
      ],
      child: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 3,
                  child: Image.asset(
                    Assets.imageWeather,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Colors.black.withValues(alpha: .4),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: kToolbarHeight),
                    SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(child: WeatherWidget()),
                              Expanded(child: ProgressWidget()),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                context.read<WeatherBloc>().add(GetWeatherEvent());
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          color: colorBackground,
                        ),
                        child: BlocBuilder<TodoBloc, TodoState>(
                          builder: (context, state) {
                            return state.todos.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: state.todos.length,
                                    itemBuilder: (context, index) {
                                      var item = state.todos[index];
                                      return TodoItemView(todoModel: item, index: index);
                                    },
                                  )
                                : Center(
                                    child: Image.asset(
                                      Assets.imageEmptyList,
                                      height: 250,
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: 'add_todo',
              onPressed: () {
                _addTodoDialog(context);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _addTodoDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AddTodoScreen();
      },
    );
  }
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.white, Colors.white.withOpacity(.3)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
).createShader(Rect.fromLTWH(100.0, 100.0, 100.0, 100.0));
