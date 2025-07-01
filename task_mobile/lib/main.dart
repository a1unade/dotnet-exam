import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'bloc/task_bloc.dart';
import 'services/task_service.dart';
import 'views/tasks_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();

  final httpLink = HttpLink('http://localhost:8080/graphql');

  final client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );

  final service = TaskService(client: client);

  runApp(MyApp(service: service));
}

class MyApp extends StatelessWidget {
  final TaskService service;

  const MyApp({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => TaskBloc(service: service)..add(LoadTasks()),
        child: const TasksPage(),
      ),
    );
  }
}
