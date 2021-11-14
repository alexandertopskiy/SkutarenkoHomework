import Foundation

// MARK: - Из методички

// MARK: - Вложенные типы (Nested Types)

// Модель игральных карт игры Blackjack.

struct BlackjackCard {
    
    // Масти (nested Suit enumeration)
    enum Suit: Character, CaseIterable {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }

    // Значение (nested Rank enumeration)
    enum Rank: Int, CaseIterable {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            // туз дает либо 1, либо 11
                case .ace: return Values(first: 1, second: 11)
            // валет, дама, король дают 10
                case .jack, .queen, .king: return Values(first: 10, second: nil)
            // все остальные дают свое значение (цифру)
                default: return Values(first: self.rawValue, second: nil)
            }
        }
    }

    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
            output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}




let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print(theAceOfSpades.description)
let testCard = BlackjackCard(rank: .queen, suit: .spades)
print(testCard.description)

// MARK: - Ссылка на вложенные типы

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print(heartsSymbol) // heartsSymbol равен "♡"

print("====")

func checkWinner(total: Int, count: Int) {
    let dealerTotal = Int.random(in: 1*count...11*count)
    print("Your score: \(total), Dealer's: \(dealerTotal)")
    switch (total,dealerTotal) {
    case let(x,y) where y > 21 || x > y:
        print("You win!")
    case let(x,y) where x == 21 && y == 21:
        print("draw!")
    case let(x,y) where y > x:
        print("You lose!")
    default:
        print("something wrong...")
    }
}

func testGame() {
    var cards : [BlackjackCard] = []
    var total = 0
    gameLoop: while true {
        
        print("One more card?", terminator: " ")
        if let x = readLine() {
            switch x.lowercased() {
            case "yes","y","да","д","1","+":
                print("ok, one more")
                let randCard = BlackjackCard.init(rank: BlackjackCard.Rank.allCases.randomElement()!, suit: BlackjackCard.Suit.allCases.randomElement()!)
                cards.append(randCard)
                if randCard.rank == .ace {
                    aceCountLoop: while true {
                        print("You get an Ace. What would you like to get, 1 or 11?", terminator: " ")
                        if let answer = readLine() {
                            switch answer.lowercased() {
                                case "1":
                                    total += 1
                                    break aceCountLoop
                                case "11":
                                    total += 11
                                    break aceCountLoop
                                default: print("Wrong answer! Type again!")
                            }
                        }
                    }
                } else {
                    total += randCard.rank.values.first
                }
                
                print("here're your cards:")
                for card in cards { print(card.description) }
                print("total: \(total)")
                
                switch total {
                    case _ where total > 21:
                        print("Your score is more that 21, you lose...")
                        break gameLoop
                    case _ where total == 21:
                        checkWinner(total: total, count: cards.count)
                        break gameLoop
                    default: break
                }

            default:
                print("\n Let's play!")
                checkWinner(total: total, count: cards.count)
                break gameLoop
            }
        }
    }
    cards.removeAll()
    total = 0
    print("=======")
    print("One more game?", terminator: " ")
    if let oneMore = readLine() {
        switch oneMore.lowercased() {
        case "yes","y","да","д","1","+": testGame()
        default: return
        }
    }
    
}

testGame()


