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
    vendorName: 'test 1 - 3',
    vendorLogo:
        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
    stories: [
      StoryItemModel(
        image:
            'http://clickgo.peaklinkdemo.com/storage/161/BrB9YY0zdjmRu7oAK9zGgajzrnt3BR-metaaW1hZ2VzICgzKS5qcGc=-.jpg',
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
            'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
        description: 'test desc',
        creationTime: DateTime.now(),
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
