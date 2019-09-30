import Foundation

/*Выполнил:     Топчий Роман
Группа:        iOS 19-2
Дата сдачи:    05.10.2019 */


print("7.1. (Set) (4 балла) Разработать игровое приложение Лото. Правила: Есть “мешок” (набор) бочонков с числами от 1 до N (N-задается при старте игры). У каждого игрока есть билет с К случайными числами из диапазона 1...N (K-задается при старте игры). За один ход из “мешка” достается один случайный бочонок. И ставится на стол. При этом, каждый игрок проверяет, есть ли у него это число в билете. Выигрывает тот игрок, у которого все числа из билета будут на столе. При выигрыше игрока выдать сообщение.Количество игроков, Количество бочонков (N) и размер билета игрока задается при старте игры. Смотри пример в конце этого файла.\n")

func readingInt(incomeValue: inout Int?, line: String?) {
    if let input = line {
        if let int = Int(input) {
            incomeValue = int
            //print("Entered input is \(int) of the type:\(type(of: int))")
        }
        else {
            print("Entered input is \(input) of the type:\(type(of: input))")
        }
    }
}



func fillBag(bag : inout Set<Int>, numberOfKeg : Int) {
    for element in 1...numberOfKeg {
        bag.insert(element)
    }
    //print("Bag contain: \(bag)")
}


func giveCards(numberOfPlayers: Int, сardSize : Int, numberOfKeg : Int, playersCards : inout [Set<Int>]) {
    for _ in 1...numberOfPlayers {
        var card : Set<Int> = []
        while card.count < сardSize {
            card = card.union([Int.random(in: 1...numberOfKeg)])
        }
        playersCards.append(card)
    }
}



func randomKeg(bag : Set<Int>, numberOfKeg : Int) -> Int {
    var rnd : Int?
    while rnd == nil || bag.intersection([rnd!]).isEmpty == true {
        rnd = Int.random(in: 0...numberOfKeg)
    }
    return rnd!  //обратить внимание если полезут ошибки
}




var numberOfPlayers : Int?
var numberOfKeg : Int?
var kegNumber : Int?
var сardSize : Int?
var table : Set<Int> = []
var bag : Set<Int> = []
var playersCards : [Set<Int>] = []
var winner = false
var round : Int = 0



//MARK: Определение количества играков
while numberOfPlayers == nil {
    print("\nВведи количество играков")
    
    readingInt(incomeValue: &numberOfPlayers, line: readLine())
    
    if let _ = numberOfPlayers {
        if numberOfPlayers! <= 0 {
            print("Введено отрицательное число!!! Будь внимателен! \(numberOfPlayers!) < 0")
            numberOfPlayers = nil
        }
    }
}

//MARK: Определение количества бочонков в мешке
while numberOfKeg == nil {
    print("\nВведи количество бочонков в мешке")
    
    readingInt(incomeValue: &numberOfKeg, line: readLine())
    
    if let _ = numberOfKeg {
        if numberOfKeg! <= 0 {
            print("Введено отрицательное число!!! Будь внимателен! \(numberOfKeg!) < 0")
            numberOfKeg = nil
        }
    }
}

fillBag(bag: &bag, numberOfKeg: numberOfKeg!)

//MARK: Определение количества чисел в билете
while сardSize == nil {
    print("\nВведи количество чисел в билете")
    
    readingInt(incomeValue: &сardSize, line: readLine())
   
    if let _ = сardSize {
        if сardSize! <= 0 {
            сardSize = nil
            print("Введено отрицательное число!!! Будь внимателен!")
        }
        else if сardSize! > numberOfKeg! {
            print("Введено количество чисел в билете превышающее количество бочонков в мешке!!! \(сardSize!) > \(numberOfKeg!)")
            сardSize = nil
        }
    }
}


giveCards(numberOfPlayers: numberOfPlayers!, сardSize: сardSize!, numberOfKeg: numberOfKeg!, playersCards: &playersCards)
print("Старт!!! В мешке бочонки от 1 до \(numberOfKeg!)")




//MARK: GAME
repeat{

    round += 1
    print("\n===========================================================\nROUND № : \(round)")
    
//MARK: Выбор бочонка / ввод номера бочонка
    while kegNumber == nil  {
        print("\nОткрыть следующий бочонок! Введи номер. Или просто нажми Enter.")
        if let input = readLine() {
            if let enteredValue = Int(input) {
                kegNumber = enteredValue
                if bag.intersection([enteredValue]).isEmpty == true {
                    print("Ты мухлюешь! В мешке нет такого бочонка!!")
                    kegNumber = nil
                }
            //print("Entered input is \(enteredValue) of the type:\(type(of: enteredValue))")
            }
            else{
                if input == "" {
                    kegNumber = randomKeg(bag: bag, numberOfKeg: numberOfKeg!)
                }
                else {
                    print("Entered input is \(input) of the type:\(type(of: input))")
                }
            }
        }
    }
    
//MARK: Выставление на стол бочонка из мешка
    table.insert(kegNumber!)
    bag.remove(kegNumber!)
    print("На столе: \(table)")
    kegNumber = nil
    
    
    
    for (playerIndex,playerCard) in playersCards.enumerated() {
//MARK: Вычеркивание в карточках номера соответствующего номеру бочонка
        let result = "\(playerIndex): \(playerCard) - Открыто \(сardSize! - playerCard.subtracting(table).count) из \(сardSize!) - осталось \(playerCard.subtracting(table)) "

//MARK: Вычеркивание в карточках номера соответствующего номеру бочонка. Определение победителя
        if playerCard.subtracting(table).isEmpty {
            print(result + "==WINNER==")
            winner = true
        }
        else {
            print(result)
        }
    }
}
while winner == false
print("!!!GAME OVER!!!")
