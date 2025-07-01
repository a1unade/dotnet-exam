const String addTaskMutation = '''
mutation AddTask(\$title: String!, \$description: String) {
  addTask(title: \$title, description: \$description) {
    id
    title
    description
  }
}
''';

const String deleteTaskMutation = '''
mutation DeleteTask(\$id: Int!) {
  deleteTask(id: \$id)
}
''';

const String updateTaskMutation = '''
mutation UpdateTask(\$id: Int!, \$title: String!, \$description: String!) {
  updateTask(id: \$id, title: \$title, description: \$description) {
    id
    title
    description
  }
}
''';