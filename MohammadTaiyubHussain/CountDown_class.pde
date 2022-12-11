class CountDown
{
  private int durationSeconds ;


  public CountDown(int duration)
  {
    this.durationSeconds = duration;
  }

  public int getRemainingTime() { //return the seconds left on the timer or 0
    return max(0, durationSeconds - millis()/1000 );
  }

  void reset() { 
    this.durationSeconds = durationSeconds + millis()/1000; //adds seconds back onto the timer
  }
}
