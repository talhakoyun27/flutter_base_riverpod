enum AppEndpoint {
  login("user/login"),
  fetchPosts("posts"),
  fetchPostsDetail("posts/detail"),
  fetchProfile("user/profile"),
  ;

  final String value;
  const AppEndpoint(this.value);
}
