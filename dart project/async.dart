void main() async {
  try {
    final result = await Future.wait([
      performAsyncOperation('Operation 1'),
      performAsyncOperation('Operation 2'),
      performAsyncOperation('Operation 3'),
    ]);

    print('All operations completed:');
    for (var value in result) {
      print(value);
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

Future<String> performAsyncOperation(String operation) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Completed $operation';
}
