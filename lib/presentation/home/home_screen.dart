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
                              Expanded(child: WeatherScreen()),
                              Expanded(
                                child: CircularPercentIndicator(
                                  radius: 80,
                                  lineWidth: 20,
                                  percent: 0.4,
                                  progressColor: colorPrimary,
                                  backgroundColor: colorBackground,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    "40%",
                                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white),
                                  ),

                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                context.read<WeatherCubit>().getWeather();
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
                        child: BlocBuilder<TodoCubit, TodoState>(
                          builder: (context, state) {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: state.todos.length,
                              itemBuilder: (context, index) {
                                var item = state.todos[index];
                                return TodoItemView(todoModel: item, index: index);
                              },
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
          // Selector<WeatherCubit, bool>(
          //   selector: (_, trainCubit) => trainCubit.state.status.isInProgress,
          //   builder: (context, isLoading, child) {
          //     return isLoading ? showMyProgress() : const SizedBox.shrink();
          //   },
          // ),
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

Future<String> fetchData(double latitude, double longitude) async {
  var place = await getPlaceMarkFromLatLng(latitude, longitude);
  return place;
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.white, Colors.white.withOpacity(.3)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
).createShader(Rect.fromLTWH(100.0, 100.0, 100.0, 100.0));
