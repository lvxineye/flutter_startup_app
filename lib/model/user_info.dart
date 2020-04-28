class UserInformation {
  int id;
  String username;
  String avatarPic;
  String themeColor;

  UserInformation({
    this.id,
    this.username,
    this.avatarPic,
    this.themeColor,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    print('fromJOSN $json   ${json['id'].runtimeType}');
    String name = json['name'];
    int userId;
    if (null == json['name']) {
      name = json['url_name'];
    }
    if (json['id'].runtimeType == int) {
      userId = json['id'];
    } else {
      userId = int.parse((json['id']));
    }

    return UserInformation(
      id: userId,
      username: name,
      avatarPic: json['avatar_pic'],
      themeColor: json['theme_color'],
    );
  }
}
