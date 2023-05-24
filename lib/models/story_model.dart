import 'package:absher/models/story_item_model.dart';

class StoryModelDto {
  int? vendorId;
  String? vendorName;
  String? vendorLogo;
  List<StoryItemModel>? stories;

  StoryModelDto({
    this.vendorId,
    this.vendorName,
    this.vendorLogo,
    this.stories,
  });

  StoryModelDto.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    vendorId = json['restaurantId'];
    vendorName = json['restaurantName'];
    vendorLogo = json['restaurantLogo'];
    stories = StoryItemModel.listFromJson(json['stories']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': vendorId,
      'restaurantName': vendorName,
      'restaurantLogo': vendorLogo,
      'stories': stories,
    };
  }

  static List<StoryModelDto> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => new StoryModelDto.fromJson(value)).toList();
  }
}

List<StoryModelDto> dummyStories = [
  StoryModelDto(
    vendorId: 1,
    vendorName: 'ستوري',
    vendorLogo:
        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
    stories: [
      StoryItemModel(
        video:
            'https://flutter.gitshub.io/assets-for-api-docs/assets/videos/bee.mp4',
        // 'https://vod-progressive.akamaized.net/exp=1684874668~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4813%2F19%2F499068724%2F2267024329.mp4~hmac=2bb08baa074162b9045ea4f3dedd3b1416c1bf38abba5322e6199d0abc7f4b88/vimeo-prod-skyfire-std-us/01/4813/19/499068724/2267024329.mp4?download=1&filename=can_you_solve_this_-_60721+%28360p%29.mp4',
        description: 'test desc',
        creationTime: DateTime.now().subtract(Duration(days: 20)),
      ),
      StoryItemModel(
        video:
            'https://download-video.akamaized.net/2/download/8417a903-ce1d-41c6-9f55-47b231f2482d/3daba1d8/139330%20%28720p%29.mp4?__token__=st=1684793450~exp=1684879970~acl=%2F2%2Fdownload%2F8417a903-ce1d-41c6-9f55-47b231f2482d%2F3daba1d8%2F139330%2520%2528720p%2529.mp4%2A~hmac=9156c20a8579b2c11b339805dcb89f474a5ad6b93ae6abfa8904a3b694c0bc23&r=dXMtZWFzdDE%3D',
        description: 'test desc',
        creationTime: DateTime.now().subtract(Duration(days: 200)),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now().subtract(Duration(minutes: 1)),
      ),
    ],
  ),
  StoryModelDto(
    vendorId: 1,
    vendorName: 'test 2 - 2',
    vendorLogo:
        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
    stories: [
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/161/BrB9YY0zdjmRu7oAK9zGgajzrnt3BR-metaaW1hZ2VzICgzKS5qcGc=-.jpg',
        description: 'test desc',
        creationTime: DateTime.now().subtract(Duration(days: 500)),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
    ],
  ),
  StoryModelDto(
    vendorId: 1,
    vendorName: 'test 3 - 1',
    vendorLogo:
        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
    stories: [
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
    ],
  ),
  StoryModelDto(
    vendorId: 1,
    vendorName: 'test 4 - 2',
    vendorLogo:
        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
    stories: [
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
    ],
  ),
  StoryModelDto(
    vendorId: 1,
    vendorName: 'test 5 - 4',
    vendorLogo:
        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
    stories: [
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        video:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        video:
            'https://vod-progressive.akamaized.net/exp=1684874668~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4813%2F19%2F499068724%2F2267024329.mp4~hmac=2bb08baa074162b9045ea4f3dedd3b1416c1bf38abba5322e6199d0abc7f4b88/vimeo-prod-skyfire-std-us/01/4813/19/499068724/2267024329.mp4?download=1&filename=can_you_solve_this_-_60721+%28360p%29.mp4',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
    ],
  ),
  StoryModelDto(
    vendorId: 1,
    vendorName: 'test 6 - 5',
    vendorLogo:
        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
    stories: [
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
    ],
  ),
  // StoryModelDto(
  //   vendorId: 1,
  //   vendorName: 'test2',
  //   vendorLogo:
  //       'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
  //   stories: [
  //     StoryItemModel(
  //       image:
  //           'http://clickgo.peaklinkdemo.com/storage/161/BrB9YY0zdjmRu7oAK9zGgajzrnt3BR-metaaW1hZ2VzICgzKS5qcGc=-.jpg',
  //       description: 'test desc',
  //       creationTime: DateTime.now(),
  //     ),
  //     StoryItemModel(
  //       image:
  //           'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
  //       description: 'test desc',
  //       creationTime: DateTime.now(),
  //     ),
  //   ],
  // ),
  // StoryModelDto(
  //   vendorId: 1,
  //   vendorName: 'test1',
  //   vendorLogo:
  //       'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
  //   stories: [
  //     StoryItemModel(
  //       image:
  //           'http://clickgo.peaklinkdemo.com/storage/161/BrB9YY0zdjmRu7oAK9zGgajzrnt3BR-metaaW1hZ2VzICgzKS5qcGc=-.jpg',
  //       description: 'test desc',
  //       creationTime: DateTime.now(),
  //     ),
  //     StoryItemModel(
  //       image:
  //           'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
  //       description: 'test desc',
  //       creationTime: DateTime.now(),
  //     ),
  //     StoryItemModel(
  //       image:
  //           'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
  //       description: 'test desc',
  //       creationTime: DateTime.now(),
  //     ),
  //   ],
  // ),
  // StoryModelDto(
  //   vendorId: 1,
  //   vendorName: 'test2',
  //   vendorLogo:
  //       'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
  //   stories: [
  //     StoryItemModel(
  //       image:
  //           'http://clickgo.peaklinkdemo.com/storage/161/BrB9YY0zdjmRu7oAK9zGgajzrnt3BR-metaaW1hZ2VzICgzKS5qcGc=-.jpg',
  //       description: 'test desc',
  //       creationTime: DateTime.now(),
  //     ),
  //     StoryItemModel(
  //       image:
  //           'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
  //       description: 'test desc',
  //       creationTime: DateTime.now(),
  //     ),
  //   ],
  // ),
];
