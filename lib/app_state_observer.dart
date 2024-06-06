class AppStateObserver{
  const AppStateObserver({
    required this.call,
  });

  final void Function(bool back) call;
}