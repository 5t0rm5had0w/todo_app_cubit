import '../../exports.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return CircularPercentIndicator(
          radius: 80,
          lineWidth: 20,
          animation: true,
          animationDuration: 500,
          animateFromLastPercent: true,
          percent: context.read<TodoBloc>().todosFinishPercent,
          progressColor: colorPrimary,
          backgroundColor: colorBackground,
          circularStrokeCap: CircularStrokeCap.round,
          center: AnimatedFlipCounter(
            duration: Duration(milliseconds: 500),
            suffix: "%",
            value: (context.read<TodoBloc>().todosFinishPercent * 100).round(),
            textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white), // pass in a value like 2014
          ),
        );
      },
    );
  }
}
