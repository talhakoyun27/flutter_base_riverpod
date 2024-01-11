enum AppEndpoint {
  login("user/login"),
  fetchPosts("posts"),
  fetchPostsDetail("posts/detail"),
  fetchProfile("user/profile"),
  fetchVersion("version"),
  ;

  final String value;
  const AppEndpoint(this.value);
}
