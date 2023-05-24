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
            'https://vod-progressive.akamaized.net/exp=1685011400~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4710%2F7%2F198553511%2F668751288.mp4~hmac=f2851ef3406c7e43ad12729a6ae9ff2e0c9a9d2fcceb4c42214a4717131f9b5c/vimeo-prod-skyfire-std-us/01/4710/7/198553511/668751288.mp4?download=1&filename=soap_bubble_-_7101+%28360p%29.mp4',
        description: 'تعليق على الستوري',
        creationTime: DateTime.now().subtract(Duration(days: 3)),
        totalViewsCount: 29,
      ),
      StoryItemModel(
        video:
            'https://vod-progressive.akamaized.net/exp=1684998314~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2361%2F5%2F136808389%2F405860900.mp4~hmac=0c7b82ecf5d38eb21e9542c902a85ef64f9453ff68bdf04e6eb5b18e2c2c7e6f/vimeo-prod-skyfire-std-us/01/2361/5/136808389/405860900.mp4?download=1&filename=success_-_468+%28360p%29.mp4',
        description:
            'test desc test desc test desc test desc test desc test desc test desctest desctest desc test desctest desc test desc test desc test desc test desc test desc test desctest desctest desc test desctest desc test desc test desc test desc test desc test desc test desctest desctest desc test desc ',
        creationTime: DateTime.now().subtract(Duration(hours: 5)),
        totalViewsCount: 61661,
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: null,
        creationTime: DateTime.now().subtract(Duration(minutes: 4)),
        totalViewsCount: 8181915616,
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
        video:
            'https://vod-progressive.akamaized.net/exp=1684975299~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F3967%2F9%2F244835811%2F882240778.mp4~hmac=60e94dad0c2cb31cfaf370ff7748bbbba625b7bacba38ad556241d3834d1514f/vimeo-prod-skyfire-std-us/01/3967/9/244835811/882240778.mp4?download=1&filename=piano_-_13071+%28540p%29.mp4',
        description:
            'test desc test desc test desc test desc test desc test desc test desctest desctest desc test desctest desc test desc test desc test desc test desc test desc test desctest desctest desc test desctest desc test desc test desc test desc test desc test desc test desctest desctest desc test desc ',
        creationTime: DateTime.now().subtract(Duration(hours: 10)),
        totalViewsCount: 2958919191,
      ),
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
        description: 'test desc',
        creationTime: DateTime.now(),
        totalViewsCount: 494915,
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
        video:
            'https://vod-progressive.akamaized.net/exp=1685011812~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4484%2F17%2F447422877%2F1963648898.mp4~hmac=c1bc5db34546936c8150d323f1de44be18c7302e6768741cab3b51bd42b37c56/vimeo-prod-skyfire-std-us/01/4484/17/447422877/1963648898.mp4?download=1&filename=rocket_-_46241+%28360p%29.mp4',
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
            'http://clickgo.peaklinkdemo.com/storage/235/nj7A475vXPK98M7fNpcTboxMjqDKjA-metaMTY2OTgwNzg3Ny5qcGc=-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        video:
            "https://vod-progressive.akamaized.net/exp=1685011825~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F1757%2F7%2F183788612%2F604924487.mp4~hmac=9231db57c86ccf99b8627fd61c483196dda8fd9b05160d2c9bbd8da4b3ee9c37/vimeo-prod-skyfire-std-us/01/1757/7/183788612/604924487.mp4?download=1&filename=science_-_5453+%28360p%29.mp4",
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
            'http://clickgo.peaklinkdemo.com/storage/218/qp57bUBu0uuIIhOr5GjwxpFSFBVYiI-metaZG93bmxvYWQgKDUpLmpwZw==-.jpg',
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
];
