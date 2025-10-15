class Images {
  Images._();

  static String _call(String image) => "assets/image/$image";

  static String onboard1 = _call("onboard1.png");
  static String onboard2 = _call("onboard2.png");
  static String onboard3 = _call("onboard3.png");
  static String login = _call("login.png");
}

List<String> dummyAvatars = const [
  'https://i.pravatar.cc/150?img=1',
  'https://i.pravatar.cc/150?img=2',
  'https://i.pravatar.cc/150?img=3',
  'https://i.pravatar.cc/150?img=4',
  'https://i.pravatar.cc/150?img=5',
  'https://i.pravatar.cc/150?img=6',
  'https://i.pravatar.cc/150?img=6',
  'https://i.pravatar.cc/150?img=6',
];
