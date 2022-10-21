class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Quality Food',
      image: 'images/quality.svg',
      discription: "Welcome to Restaurant app  , a great"
          "app to give you nearby dishes and "
          "your favorite dishes along the way "),
  UnbordingContent(
      title: 'Fast Delevery',
      image: 'images/delevery.svg',
      discription: "Fast delivery of your facvorite dishe to "
          "any location country wide with in less  "
          "15 minutes "),
  UnbordingContent(
      title: 'Reward surprises',
      image: 'images/reward.svg',
      discription: "Reward and surprises to our clients ,"
          "is a mutual habit to all of the orders"
          "we process by where we include a "
          "surprise and reward to your favorite"
          "dishes"),
];
