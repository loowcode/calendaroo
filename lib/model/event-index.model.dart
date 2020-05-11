class EventIndex implements Comparable<EventIndex>{
  int index;
  DateTime dateTime;

  EventIndex(this.index, this.dateTime);

  @override
  int compareTo(other) {
    return this.dateTime.compareTo(other.dateTime);
  }
}