var compchoicearray: [Int] = []
var rounds = 1
var number:Int!
var userchoicearray: [Int] = []
var compchoiceindex: [Int] = [0,1]
var scoreuser = 0
var scoreai = 0
var timeperround: [Float] = []


while rounds <= 4 {
  rounds += 1 
let start = CFAbsoluteTimeGetCurrent()
let startfloat = FLoat(start)
  print("Enter 0 to cooperate, 1 to cheat") //1 cheat 0 cooperate
  let compchoice = compchoiceindex.randomElement() //comp compchoice
  compchoicearray.append(compchoice!)
  number = Int(readLine()!)//input
  userchoicearray.append(number)
//logic
  if number == 1 && compchoice == 1 { //cheat cheat
    print("you both cheat, no one benefits")
  } else if number == 0 && compchoice == 0 { //coop coop
    print("you both cooperate, you both gain a point")
    scoreuser += 1
    scoreai += 1
  } else if number == 1 && compchoice == 0 { //cheat coop
    print("you cheated, they cooperated, you steal a point")
    scoreuser += 1
    scoreai -= 1
  } 
  else if number == 0 && compchoice == 1 { //coop cheat
    print("they cheated, you cooperated, they steal a point")
    scoreuser -= 1
    scoreai += 1
  } 
  else {
      print("error in selection please try again")
      print("Enter 0 to cooperate, 1 to cheat")
      number = Int(readLine()!)
    }
  let stop = CFAbsoluteTimeGetCurrent()
  let stopfloat = FLoat(stop)
  let timeappend = stopfloat - startfloat
  timeperround.append(timeappend) 
  if rounds == 5 {
  print()
  print ("Thanks for playing")//exit
  }
}


//obvs data
print (userchoicearray, compchoicearray, timeperround)

print("you scored:",scoreuser, "ai scored:",scoreai)
