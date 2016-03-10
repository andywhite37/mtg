package mtg.client.state;

enum Loader<TLoading, TLoaded, TFailed> {
  Loading(data : TLoading);
  Loaded(data : TLoaded);
  Failed(data : TFailed);
}
