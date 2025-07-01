import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/mutations.dart';
import '../models/task.dart';
import '../graphql/queries.dart';

class TaskService {
  final GraphQLClient client;

  TaskService({required this.client});

  Future<List<Task>> fetchTasks() async {
    final result = await client.query(
      QueryOptions(
        document: gql(getTasksQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final tasksJson = result.data?['tasks'] as List<dynamic>? ?? [];
    return tasksJson.map((json) => Task.fromJson(json)).toList();
  }

  Future<Task> addTask({required String title, String? description}) async {
    final options = MutationOptions(
      document: gql(addTaskMutation),
      variables: {
        'title': title,
        if (description != null && description.isNotEmpty) 'description': description,
      },
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data?['addTask'];
    if (data == null) throw Exception('No data returned');

    return Task.fromJson(data);
  }

  Future<void> deleteTask(int id) async {
    final options = MutationOptions(
      document: gql(deleteTaskMutation),
      variables: {'id': id},
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }

  Future<Task> updateTask(int id, String title, String description) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(updateTaskMutation),
        variables: {
          'id': id,
          'title': title,
          'description': description,
        },
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final taskJson = result.data!['updateTask'];
    return Task.fromJson(taskJson);
  }
}
