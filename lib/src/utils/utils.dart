String parseDate(String date) {
  DateTime pubDate = DateTime.parse(date);
  DateTime now = DateTime.now();

  int diff = now.difference(pubDate).inDays.toInt();

  if (diff >= 365) {
    return (diff ~/ 365).toString() + " years ago";
  } else if (diff >= 60) {
    return (diff ~/ 30).toString() + " months ago";
  } else if (diff >= 30) {
    return "1 month ago";
  } else if (diff >= 14) {
    return (diff ~/ 7).toString() + " weeks ago";
  } else if (diff >= 7) {
    return "1 week ago";
  } else if (diff >= 2) {
    return (diff).toString() + " days";
  } else if (diff == 1) {
    return "1 day ago";
  }

  diff = now.difference(pubDate).inMinutes.toInt();
  if (diff >= 120) {
    return (diff ~/ 60).toString() + " hours ago";
  } else if (diff >= 60) {
    return "1 hour ago";
  } else if (diff >= 2) {
    return (diff).toString() + " minutes ago";
  } else {
    return "1 minute ago";
  }
}