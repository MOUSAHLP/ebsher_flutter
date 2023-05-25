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
        // video:
        //     'https://vod-progressive.akamaized.net/exp=1685011400~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4710%2F7%2F198553511%2F668751288.mp4~hmac=f2851ef3406c7e43ad12729a6ae9ff2e0c9a9d2fcceb4c42214a4717131f9b5c/vimeo-prod-skyfire-std-us/01/4710/7/198553511/668751288.mp4?download=1&filename=soap_bubble_-_7101+%28360p%29.mp4',
        image:
            'https://pixabay.com/get/g5c339fca2117fdcedda989d5e39c5969c60b2a329d46c556b4b28c6cfcc99e7ec3ae5441452acc0a17bb811f6ddd0c5f7d362a153ea6b0d62ed4f9e671a0463e776aaa3e28ce0100a8d76903ea37c160_1280.jpg?attachment=',
        description: 'تعليق على الستوري',
        creationTime: DateTime.now().subtract(Duration(days: 3)),
        totalViewsCount: 29,
      ),
      StoryItemModel(
        // video:
        //     'https://vod-progressive.akamaized.net/exp=1684998314~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2361%2F5%2F136808389%2F405860900.mp4~hmac=0c7b82ecf5d38eb21e9542c902a85ef64f9453ff68bdf04e6eb5b18e2c2c7e6f/vimeo-prod-skyfire-std-us/01/2361/5/136808389/405860900.mp4?download=1&filename=success_-_468+%28360p%29.mp4',
        image:
            'https://pixabay.com/get/gf041ff417638d4ece53402bd773d1fbb5148e1b0b8715d9b4f3afaf5e23a9a918dec30bf68d68dff386014aecc457d9f1259e44dd6ba1f91843570d5ee64eef010ea471eafdb8626c34302255f1e7b75_1280.jpg?attachment=',
        description:
            'test desc test desc test desc test desc test desc test desc test desctest desctest desc test desctest desc test desc test desc test desc test desc test desc test desctest desctest desc test desctest desc test desc test desc test desc test desc test desc test desctest desctest desc test desc ',
        creationTime: DateTime.now().subtract(Duration(hours: 5)),
        totalViewsCount: 61661,
      ),
      StoryItemModel(
        video:
            'https://vod-progressive.akamaized.net/exp=1685011400~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4710%2F7%2F198553511%2F668751288.mp4~hmac=f2851ef3406c7e43ad12729a6ae9ff2e0c9a9d2fcceb4c42214a4717131f9b5c/vimeo-prod-skyfire-std-us/01/4710/7/198553511/668751288.mp4?download=1&filename=soap_bubble_-_7101+%28360p%29.mp4',
        // image:
        //       'http://clickgo.peaklinkdemo.com/storage/76/5dXrgeUiZIH0eF3EiqpOzlyB9Cau5M-metaZG93bmxvYWQuamZpZg==-.jpg',
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
        // video:
        //     'https://vod-progressive.akamaized.net/exp=1684975299~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F3967%2F9%2F244835811%2F882240778.mp4~hmac=60e94dad0c2cb31cfaf370ff7748bbbba625b7bacba38ad556241d3834d1514f/vimeo-prod-skyfire-std-us/01/3967/9/244835811/882240778.mp4?download=1&filename=piano_-_13071+%28540p%29.mp4',
        video:
            'https://vod-progressive.akamaized.net/exp=1684998314~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2361%2F5%2F136808389%2F405860900.mp4~hmac=0c7b82ecf5d38eb21e9542c902a85ef64f9453ff68bdf04e6eb5b18e2c2c7e6f/vimeo-prod-skyfire-std-us/01/2361/5/136808389/405860900.mp4?download=1&filename=success_-_468+%28360p%29.mp4',

        // image:
        //       'https://pixabay.com/get/ge0e5b4f08e8a2e16d50dd200d717e4def1a5b6658f39e6f547878ab121dd5e85523949d709a1b9680d0d204013622519edfdae94c66225b5fc194000507cd112e362890837f5867f6d806f21e5c9ca03_1280.jpg?attachment=',
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
            'https://pixabay.com/get/g2292b6883a10367796728dfd0551f33de76f86bcbb81889c79f6e0588c9156826132f31a5cdaa73623b897d597f6f24dfef5aa1fc1aeca36dbe7e15e12da75d4b1c8aa6b35c7cabd2e8e0d4c9d7b6301_1280.jpg?attachment=',
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
        // video:
        //     'https://vod-progressive.akamaized.net/exp=1685011812~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4484%2F17%2F447422877%2F1963648898.mp4~hmac=c1bc5db34546936c8150d323f1de44be18c7302e6768741cab3b51bd42b37c56/vimeo-prod-skyfire-std-us/01/4484/17/447422877/1963648898.mp4?download=1&filename=rocket_-_46241+%28360p%29.mp4',
        image:
            'https://pixabay.com/get/g8eafd1b721eafe461071b9fd05d89295f5ef5b6b698023ab62bcf40c59510878c77bec5b040539607258bb0fc8c3ae817ac5adcf587222ed69556974c7fc9423c12afbc155792506e4ca3ebbdd01a2cb_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'https://pixabay.com/get/g8d02c31c02a0e32d144cf165a5b06af9b3ef8ec101e9d5cb4132c815dbba924e934c7b70b995a6cae14d5e7f504afd03422833db50e0796c9c570a8cb87d746d6e5e6d7a19835e4ddec50dc4271471a1_1280.jpg?attachment=',
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
            'https://pixabay.com/get/gbc03e4ebb57e6cc2e102fd79efc1a22842e2afefd85ba0c4c44e545557d0418bab411e4abf0402d55898610773ae5b3c523331c9edcfc5d0811569c5e391a1acb48c75a4de0b1aaab90c994c9f90ce4d_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        // video:
        //     "https://vod-progressive.akamaized.net/exp=1685011825~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F1757%2F7%2F183788612%2F604924487.mp4~hmac=9231db57c86ccf99b8627fd61c483196dda8fd9b05160d2c9bbd8da4b3ee9c37/vimeo-prod-skyfire-std-us/01/1757/7/183788612/604924487.mp4?download=1&filename=science_-_5453+%28360p%29.mp4",
        image:
            "https://pixabay.com/get/gbc836fcd5de2084599598bea1261c5fa4ff28fec69bd8a1a7d93be159c102fd4badaaef776e74979f096ce27658b1ef908738c6bdbac67a0d02f27c3426c82931df21fcde4dc51ef46714318a80ebbf3_1280.jpg?attachment=",
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'https://pixabay.com/get/g275015bea1f103462f945edba5bf14f1a64c4057d1d252210296c0e629cb94913b7a596fa5845835de84c9acc6a2093366096add9a7d50d71c33250f4787cf0ca23fb3b08c44155100e3cd15c2297b58_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        // video:
        //     'https://vod-progressive.akamaized.net/exp=1684874668~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4813%2F19%2F499068724%2F2267024329.mp4~hmac=2bb08baa074162b9045ea4f3dedd3b1416c1bf38abba5322e6199d0abc7f4b88/vimeo-prod-skyfire-std-us/01/4813/19/499068724/2267024329.mp4?download=1&filename=can_you_solve_this_-_60721+%28360p%29.mp4',
        image:
            'https://pixabay.com/get/g16daf195b40bf84f79a0359f04ffcaf4b7a9379b5d2c59657c222dc72adee9996f67a87775da604124429a00083bdce507f0bad6f04f07cd0a68b6d8aca0e5cea5d70b7ef0be7da92e6bbb89ff684264_1280.jpg?attachment=',
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
            'https://pixabay.com/get/g060ab83c8c9ef302f13e0eecaf7881ab2840712702029d463119aa1ceba6cb99b65db398ffdab0b5dc2d7a48c2dd3db6b92258fe7ecd6a0ab8f2f16cdce0ce60b558fb9e41b48a907f7dca2aa7ca2368_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'https://pixabay.com/get/gcd990bb34c0f4822fabc5ce9fbb27a345a870d2d9dd92057e331e303a94b53a3761cf1d8e7e3c518e90757b32fdd0ccf9fb75e97f798b8853001be3c5e146221c8e9a858f3554f98c4b09027bbdedf8f_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'https://pixabay.com/get/g6f2bb051b905424592993560ed5d9d4999d8f8dadd523254cb536124c825d4eac9973cd58f5bdd569dbb8b3d3d8d4ccf9a89abaeebcb837538892cff6d2288cc41b2bcf33c7366f4c55dfa1a731a52fa_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'https://pixabay.com/get/g441204eaf492ef285fbbe7a82fd4a813efc71eef8ef64ab164af2fe14ca13d91ceed6bfa01a0923411040f744ca85aa3ff31955a9cd624d4f1f342d500a97ffa0b4a8666ad449cfc69d55aa65056a5e7_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
      StoryItemModel(
        image:
            'https://pixabay.com/get/gbcf83426625abfa23dde20a49302411f7b5348d8cb7e1c9a6d487e1fa1f62cb7ddeab989af60bae0b9b6f17adbf2f0553cc42d2442b3a5b368bc3b0ccfd4d3efc54a59bd6a9c93f17568daca9d6749bc_1280.jpg?attachment=',
        description: 'test desc',
        creationTime: DateTime.now(),
      ),
    ],
  ),
];
