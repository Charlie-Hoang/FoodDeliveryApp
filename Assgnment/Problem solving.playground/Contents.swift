import Foundation

func transformString(input: String, move: Int) -> String{
    var chars = Array(input)
    
    for i in 0..<chars.count{
        let asciiValue = chars[i].asciiValue!
        let intValue = Int(asciiValue)
        var sum = intValue + (move % 26)
        if sum > 122{
            sum -= 26
        }
        chars[i] = Character(UnicodeScalar(sum)!)
    }
    return String(chars)
}

print(transformString(input: "abc", move: 2))//cde
print(transformString(input: "abc", move: 28))//cde
print(transformString(input: "aBcDf", move: 28))//cDeFh
print(transformString(input: "xyz", move: 3))//abc
print(transformString(input: "xyz", move: 263))//abc
