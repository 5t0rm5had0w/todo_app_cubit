import '../../exports.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  final int id;
  final String name;
  bool isDone;

  TodoModel(this.id, this.name, {this.isDone = false});

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
