//
//  CalculatorViewController.swift
//  Numbers converter
//
//  Created by Дархан Есенкул on 04.02.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var label: UILabel!
    var segment = 0
    var firstNumber = ""
    var secondNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
    }
    
    @IBAction func textField1(_ sender: UITextField){firstNumber = sender.text ?? ""}
    @IBAction func textField2(_ sender: UITextField){secondNumber = sender.text ?? ""}
    
    @IBAction private func SegmentedControlDidTap(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0: return segment = 0
        case 1: return segment = 1
        case 2: return segment = 2
        default: break
        }
    }
    @IBAction private func clearButtonDidTap(_ sender: UIButton){
        label.text = ""
        textField1.text = ""
        textField2.text = ""
    }
    @IBAction private func additionButtonDidTap(_ sender: UIButton){
        if segment == 0{
            label.text = binaryAdditionCases(first: firstNumber, second: secondNumber)
        }
        else if segment == 1{
            label.text = octalAddition(first: firstNumber, second: secondNumber)
        }
        else if segment == 2{
            label.text = hexAddition(first: firstNumber, second: secondNumber)
        }
    }
    @IBAction private func substractionButtonDidTap(_ sender: UIButton){
        if segment == 0{
            label.text = binarySubtraction(first: firstNumber, second: secondNumber)
        }
        else if segment == 1{
            label.text = octalSubtraction(first: firstNumber, second: secondNumber)
        }
        else if segment == 2{
            label.text = hexSubtraction(first: firstNumber, second: secondNumber)
        }
    }
}

extension CalculatorViewController{
    
    func binaryAdditionCases(first: String, second: String) -> String {
        var result = ""
        if first.contains(".") && second.contains("."){
            var countOfDot1 = 0
            var countOfDot2 = 0
            let checking = Array(first)
            let checking1 = Array(second)
            for i in checking{
                if i == "."{
                    countOfDot1+=1
                }
            }
            for j in checking1{
                if j == "."{
                    countOfDot2+=1
                }
            }
            if countOfDot1 == 1 && countOfDot2 == 1{
                var str1 = first.split(separator: ".")
                var str2 = second.split(separator: ".")
                var result1 = ""
                var resutl2 = ""
                var length = 0
                var length2 = 0
                result1 = binaryAddition(first: String(str1[0]), second: String(str2[0]))
                resutl2 = binaryAddition(first: String(str1[1]), second: String(str2[1]))
                if resutl2.count > String(str1[1]).count && resutl2.count>String(str2[1]).count{
                    if String(str1[1]).count > String(str2[1]).count{
                        length = str1[1].count - str2[1].count
                        for _ in 0..<length{
                            str2[1].append("0")
                        }
                        result1 = String(str1[0]) + String(str1[1])
                        resutl2 = String(str2[0]) + String(str2[1])
                        result = binaryAddition(first: result1, second: resutl2)
                        length2 = result.count - str1[1].count
                        result.insert(".", at: result.index(result.startIndex, offsetBy: length2))
                    }
                    else if String(str1[1]).count < String(str2[1]).count{
                        length = str2[1].count - str1[1].count
                        for _ in 0..<length{
                            str1[1].append("0")
                        }
                        result1 = String(str1[0]) + String(str1[1])
                        resutl2 = String(str2[0]) + String(str2[1])
                        result = binaryAddition(first: result1, second: resutl2)
                        length2 = result.count - str2[1].count
                        result.insert(".", at: result.index(result.startIndex, offsetBy: length2))
                        
                    }
                    else if String(str1[1]).count == String(str2[1]).count{
                        result1 = String(str1[0]) + String(str1[1])
                        resutl2 = String(str2[0]) + String(str2[1])
                        result = binaryAddition(first: result1, second: resutl2)
                        length2 = result.count - str2[1].count
                        result.insert(".", at: result.index(result.startIndex, offsetBy: length2))
                    }
                }
                
            }
        }
        else if first.contains(".") && !second.contains("."){
            let str = first.split(separator: ".")
            result = binaryAddition(first: String(str[0]), second: second)
            result = result + "." + String(str[1])
        }
        else if !first.contains(".") && second.contains("."){
            let str = second.split(separator: ".")
            result = binaryAddition(first: String(str[0]), second: first)
            result = result + "." + String(str[1])
        }
        else{
           result = binaryAddition(first: first, second: second)
        }
        return result
    }
    
    func binaryAddition(first: String,second: String) -> String{
        var result = ""
        let arr1 = Array(first)
        let arr2 = Array(second)
        var length1 = arr1.count - 1
        var length2 = arr2.count - 1
        var sum = 0
        while length1 >= 0 || length2 >= 0 || sum == 1 {
            sum += (length1 >= 0) ? Int(String(arr1[length1]))! : 0
            sum += (length2 >= 0) ? Int(String(arr2[length2]))! : 0
            result = String((sum % 2)) + result
            sum /=  2
            length1 -= 1
            length2 -= 1
        }
        return result
    }
    

    func binarySubtraction(first: String, second: String) -> String{
        var result = ""
            let firstBin = Array(first)
            let secondBin = Array(second)
            var carry = 0
        let maxBin = max(firstBin.count, secondBin.count)
            for i in (0..<maxBin).reversed() {
                let firstBit = i < firstBin.count ? Int(String(firstBin[i]))! : 0
                let secondBit = i < secondBin.count ? Int(String(secondBin[i]))! : 0
                var diff = firstBit - secondBit - carry
                
                if diff < 0 {
                    carry = 1
                    diff = diff + 2
                } else {
                    carry = 0
                }
                
                result = String(diff) + result
            }
            
        return String(result.reversed())
    }
    
        func octalAddition(first: String, second: String) -> String {
            let firstOctal = Array(first)
            let secondOctal = Array(second)
            var result = ""
            var carry = 0
            var firstLength = firstOctal.count - 1
            var secondLegth = secondOctal.count - 1
            while firstLength >= 0 || secondLegth >= 0 || carry > 0 {
                var sum = carry
                if firstLength >= 0 {
                    sum += Int(String(firstOctal[firstLength]))!
                    firstLength -= 1
                }
                if secondLegth >= 0 {
                    sum += Int(String(secondOctal[secondLegth]))!
                    secondLegth -= 1
                }
                result = String(sum % 8) + result
                carry = sum / 8
            }
            return result
        }
    
    func octalSubtraction(first: String, second: String) -> String {
        let firstOctalInt = Int(first, radix: 8) ?? 0
        let secondOctalInt = Int(second, radix: 8) ?? 0
        let difference = firstOctalInt - secondOctalInt
        return String(difference, radix: 8)
    }
    
    func hexAddition(first: String, second: String) -> String {
        let firstHexInt = Int(first, radix: 16) ?? 0
        let secondHexInt = Int(second, radix: 16) ?? 0
        let sum = firstHexInt + secondHexInt
        return String(sum, radix: 16).uppercased()
    }

    func hexSubtraction(first: String, second: String) -> String {
        let firstHexInt = Int(first, radix: 16) ?? 0
        let secondHexInt = Int(second, radix: 16) ?? 0
        let sum = firstHexInt - secondHexInt
        return String(sum, radix: 16).uppercased()
    }

}

