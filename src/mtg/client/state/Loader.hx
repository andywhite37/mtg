package mtg.client.state;

enum Loader<TLoading, TLoaded, TFailed> {
  Initial(state : TLoaded);
  Loading(state : TLoading);
  Refreshing(state : TLoading);
  Loaded(state : TLoaded);
  Failed(error : TFailed);
}
