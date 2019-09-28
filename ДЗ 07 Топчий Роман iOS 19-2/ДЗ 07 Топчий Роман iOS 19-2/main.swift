import Foundation

/*Выполнил:     Топчий Роман
Группа:        iOS 19-2
Дата сдачи:    05.10.2019 */


print("7.1. (Set) (4 балла) Разработать игровое приложение Лото. Правила: Есть “мешок” (набор) бочонков с числами от 1 до N (N-задается при старте игры). У каждого игрока есть билет с К случайными числами из диапазона 1...N (K-задается при старте игры). За один ход из “мешка” достается один случайный бочонок. И ставится на стол. При этом, каждый игрок проверяет, есть ли у него это число в билете. Выигрывает тот игрок, у которого все числа из билета будут на столе. При выигрыше игрока выдать сообщение.Количество игроков, Количество бочонков (N) и размер билета игрока задается при старте игры. Смотри пример в конце этого файла.\n")

func randomKeg(bag : Set<Int>, numberOfKeg : Int) -> Int {
    var rnd : Int?
    while rnd == nil || bag.intersection([rnd!]).isEmpty == true {
        rnd = Int.random(in: 0...numberOfKeg)
    }
    return rnd!  //обратить внимание если полезут ошибки
}





var kegNumber : Int?
var table : Set<Int> = []
var winner = false
let numberOfKeg : Int = 10
let quantityOfNumberInCard = 3
var bag : Set<Int> = [1,2,3,4,5,7,8,9,10]
var playersCards : [Set<Int>] = [[6,8,7],[7,5,9],[6,9,4]]

repeat{
    

while kegNumber == nil || bag.intersection([kegNumber!]).isEmpty == true {
    print("\nОткрыть следующий бочонок! Введи номер. Или просто нажми Enter.")
    if let input = readLine() {
        if let enteredValue = Int(input) {
            kegNumber = enteredValue
            if bag.intersection([kegNumber!]).isEmpty == true {
                print("Ты мухлюешь! В мешке нет такого бочонка!!")
            }
            //print("Entered input is \(enteredValue) of the type:\(type(of: enteredValue))")
        }
        else{
            if input == "" {
                kegNumber = randomKeg(bag: bag, numberOfKeg: numberOfKeg)
            }
            else {
                print("Entered input is \(input) of the type:\(type(of: input))")
            }
        }
    }
}

table.insert(kegNumber!)
bag.remove(kegNumber!)
print("На столе: \(table)")
kegNumber = nil

for (playerIndex,playerCard) in playersCards.enumerated() {
    let result = "\(playerIndex): \(playerCard) - Открыто \(quantityOfNumberInCard - playerCard.subtracting(table).count) из \(quantityOfNumberInCard) - осталось \(playerCard.subtracting(table)) "
    
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








