const String getTasksQuery = '''
query {
  tasks(
    order: { id: ASC }
  ) {
    id
    title
    description
  }
}
''';