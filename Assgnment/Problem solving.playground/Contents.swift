import Foundation
//Problem: Given a string str consisting of letters only and an integer n, the task is to replace every character of the given string by a character which is n times more than it. If the letter exceeds ‘z’, then start checking from ‘a’ in a cyclic manner.

//Solution:
//Time complexity: O(n) //n: length of the input string
//I do not know the disadvantage of using ASCII value to solve this problem
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
