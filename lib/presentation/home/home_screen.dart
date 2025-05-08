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
    context.read<WeatherCubit>().getWeather();
    context.read<TodoCubit>().getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WeatherCubit, WeatherState>(
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
            appBar: AppBar(
              title: Text("Todo"),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    var data = state.weather;
                    return data != null
                        ? Column(
                            children: [
                              8.height,
                              Text(
                                "Time: ${data.current_weather.time.replaceAll("T", " ")}",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              4.height,
                              Text(
                                "Temperature: ${data.current_weather.temperature} ${data.current_weather_units.temperature}",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              4.height,
                              Text(
                                "Wind speed: ${data.current_weather.windspeed} ${data.current_weather_units.windspeed}",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          )
                        : SizedBox();
                  },
                ),
                Expanded(
                  child: BlocBuilder<TodoCubit, TodoState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          var item = state.todos[index];
                          return TodoItemView(todoModel: item, number: index + 1);
                        },
                      );
                    },
                  ),
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
          Selector<WeatherCubit, bool>(
            selector: (_, trainCubit) => trainCubit.state.status.isInProgress,
            builder: (context, isLoading, child) {
              return isLoading ? showMyProgress() : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _addTodoDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AddTodoScreen();
      },
    );
  }
}
