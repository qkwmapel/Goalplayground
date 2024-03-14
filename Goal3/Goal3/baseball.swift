import Foundation

//var answer = [Character]()


var trialCnt : Int = 0

enum selectNum : String {
    case start = "1"
    case history = "2"
    case end = "3"
}

public class BaseballGame {
    var GameStatus : GameStatus
    init(GameStatus: GameStatus) {
        self.GameStatus = GameStatus
    }
    func GG(){
        self.GameStatus.Game()
    }
}

//게임 시작 전
class GameStatus {
    
    let recordManager = RecordManager()
    func Game(){
        var gameEnd = true
        while gameEnd{
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기")
            var Num = readLine()!
            while Int(Num) ?? 4 > 3 {
                print("올바른 숫자를 입력해주세요")
                Num = readLine()!
            }
            let select = selectNum(rawValue: Num)
    
            switch select {
            case .start :
                Start.GameStatus = GameStart()
                Start.GG()
                recordManager.add(trialCount: trialCnt)
            case .history :
                RecordManager().showRecord()
            case .end :
                gameEnd = false
            default :
                break
            }
        }
        return
    }
}

//게임 시작 클래스
class GameStart : GameStatus {
    override func Game() {
        trialCnt = 0
        let answer = makeAnswer()
        var Strike : Int
        print("< 게임을 시작합니다 >")
        repeat{
            print("숫자를 입력하세요")
            Strike = compareFunc(readLine()!,answer)
            trialCnt += 1
        }while Strike != answer.count
        
    }
    
    func makeAnswer() -> [String]{
        //Goal 랜덤 생성
        var answer = [String]()
        repeat {
            let n = String(Int.random(in: 0...9))
            if answer.count == 0 {
                if n == "0" {
                    continue
                }
            }
            if !answer.contains(n) {
                answer.append(String(n))
            }
        }while answer.count != 3
        
        return answer
    }
}

//게임 history class
class RecordManager {
    var Cnt : [Int] = []
    func add(trialCount: Int) {
        Cnt.append(trialCount)
    }
    func showRecord() {
        print("< 게임 기록 보기 >")
        for (num , trial) in Cnt.enumerated(){
            print("\(num+1)번째 게임 : 시도 횟수 - \(trial)")
        }
    }
}
//비교하는 함수
func compareFunc(_ Num: String, _ answer: [String]) -> Int{
    let NumArr : [String] = Num.map{String($0)}
    var St : Int = 0
    var Ball : Int = 0
    
    guard Int(Num) != nil else{
        print("올바르지 않은 입력값입니다")
        return 0
    }
    
    guard Set(NumArr).count == 3 else{
        print("올바르지 않은 입력값입니다")
        return 0
    }
        
    for i in 0 ..< answer.count {
        if answer[i] == NumArr[i] {
            St += 1
        }
        if answer.contains(NumArr[i]){
            Ball += 1
        }
    }
    Ball -= St
    if St == 0 && Ball == 0 {
        print("Nothing")
    }else if St == 0{
        print("\(Ball)볼")
    }else if St == answer.count{
        print("정답입니다!")
    }else if Ball == 0{
        print("\(St)스트라이크")
    }else{
        print("\(St)스트라이크 \(Ball)볼")
    }
    return St
}
