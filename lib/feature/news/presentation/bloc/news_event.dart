class NewsEvent {}

class LoadNewsEvent extends NewsEvent{
  final bool isConnected;
  LoadNewsEvent(this.isConnected);
}

class CheckConnectivityEvent extends NewsEvent{}