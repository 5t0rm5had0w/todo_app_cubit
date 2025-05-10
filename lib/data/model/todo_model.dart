import '../../exports.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  final int id;
  final String name;
  bool isDone;

  TodoModel(this.id, this.name, {this.isDone = false});

  TodoModel copyWith({
    int? id,
    String? name,
    bool? isDone,
  }) {
    return TodoModel(
      id ?? this.id,
      name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
