const Duration ONE_SECOND = Duration(seconds: 1);

String getHourAndMinuteFromSeconds(int timeInSeconds) {
  final minutes = (timeInSeconds / 60).floor().toString().padLeft(2, '0');
  final seconds = (timeInSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
