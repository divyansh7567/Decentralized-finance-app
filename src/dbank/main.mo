import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  //this 'stable' keyword keeps the value of 'currentvalue' the same even if the page refreshes
  stable var currentValue: Float = 300;
  currentValue := 300;
  Debug.print(debug_show (currentValue));

  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  let id = 1234567890;
  // Debug.print(debug_show(id));

  // function to add money in the wallet
  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  //function to withdraw money from the wallet
  public func withdraw(amount : Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    }
    else{
      Debug.print("Can't withdraw");
    }
  };

  // function to check the money balance
  // the query keyword is used to get the checkBalance value quickly without delays
  public query func checkBalance(): async Float{
    return currentValue;
  };

  // function to calculate the compound interest
  // right now the interest rate is set as 1%
  public func Compound(){
    let currenttime = Time.now();
    let timeElapsedNS = currenttime - startTime;
    let timeElapsedS = timeElapsedNS/1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currenttime;
  };
  
}