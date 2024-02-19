import UIKit
import Combine

let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

//Traditional way of finding even numbers limit to 20

func findEvenNums(nums: [Int]) -> [Int]{
    var evenNums = [Int]()
    for n in nums{
        if n % 2 == 0{
            evenNums.append(n)
        }
    }
    return evenNums
}
print("Tradition Approach : \(findEvenNums(nums: nums))")

//Combine Approach - Combine Pipeline/ Optional Chaining
nums.publisher
    .filter{ $0 % 2 == 0 }
    .collect()
    .sink{ result in
        print("Combine Approach : \(result)")
    }
