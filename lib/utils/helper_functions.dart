String getTimePassed(DateTime? dateTime) {
  if (dateTime == null) return "0s";
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inDays > 6) {
    return '${dateTime.day.toString().padLeft(2, '0')} ${_getMonthAbbreviation(dateTime.month)}';
  } else if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return '0s';
  }
}

String _getMonthAbbreviation(int month) {
  const monthAbbreviations = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return monthAbbreviations[month - 1];
}
