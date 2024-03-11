import Foundation


var Goal = [Character]()
repeat {
    let n = String(Int.random(in: 1...9))
    if !Goal.contains(n) {
        Goal.append(Character(n))
    }
}while Goal.count != 3

var St : Int = 0
var Ball : Int = 0

func compareFunc(_ Num: String){
    let NumArr = Array(Num)
    St = 0
    Ball = 0
    
    if Int(Num) == nil {
        print("올바르지 않은 입력값입니다")
        return
    }
    
    if Set(NumArr).count != 3 {
        print("올바르지 않은 입력값입니다")
        return
    }
        
    for i in 0 ..< Goal.count {
        if Goal[i] == NumArr[i] {
            St += 1
        }
        if Goal.contains(NumArr[i]){
            Ball += 1
        }
    }
    Ball -= St
    if St == 0 && Ball == 0 {
        print("Nothing")
    }else if St == 0{
        print("\(Ball)볼")
    }else if St == Goal.count{
        print("정답입니다!")
    }else if Ball == 0{
        print("\(St)스트라이크")
    }else{
        print("\(St)스트라이크 \(Ball)볼")
    }
}

var input : String = "0"

print("< 게임을 시작합니다 >")

repeat{
    print("숫자를 입력하세요")
    input = readLine()!
    
    compareFunc(input)
}while St != Goal.count
