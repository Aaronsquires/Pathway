
class Jobs {
  final String category;
  final String jobTitle;
  final String gradeRequired;
  final String endDate;
  final String location;
  final String id;
  final String description;
  final String logo;
  final int pay;
  final String jobUrl;

  Jobs({this.category, this.description, this.endDate,this.gradeRequired,this.id,this.jobTitle,this.location,this.logo, this.pay, this.jobUrl});

  Jobs.fromJson(Map<String, dynamic> parsedJson)
    : category = parsedJson['category'],
      jobTitle = parsedJson['jobTitle'],
      gradeRequired = parsedJson['gradeRequired'],
      endDate = parsedJson['endDate'],
      location = parsedJson['location'],
      id = parsedJson['id'],
      description = parsedJson['description'],
      logo = parsedJson['logo'],
      pay = parsedJson['pay'],
      jobUrl = parsedJson['jobUrl'];
}

class ChipItem {
  final String avatar;
  final String title;

  ChipItem({this.avatar, this.title});
}