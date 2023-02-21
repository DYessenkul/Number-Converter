//
//  ViewController.swift
//  Numbers converter
//
//  Created by Дархан Есенкул on 31.01.2023.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    var firstSegment: Int = 0
    var secondSegment: Int = 0
    var numberToConvert: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
    }
    
    @IBAction func textField(_ sender: UITextField){numberToConvert = sender.text ?? ""}
    @IBAction private func firstSegmentedControlDidTap(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0: return firstSegment = 0
        case 1: return firstSegment = 1
        case 2: return firstSegment = 2
        case 3: return firstSegment = 3
        default: break
        }
    }
    @IBAction private func secondSegmentedControlDidTap(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0: return secondSegment = 0
        case 1: return secondSegment = 1
        case 2: return secondSegment = 2
        case 3: return secondSegment = 3
        default: break
        }
    }
    @IBAction private func clearButtonDidTap(_ sender: UIButton){
        label.text = ""
        textField.text = ""
    }
    @IBAction private func convertButtonDidtap(_ sender: UIButton){
        if firstSegment == secondSegment{label.text = ""}
        else if firstSegment == 0 && secondSegment == 1{convertFromBinToOctal(binaryNumber: numberToConvert)}
        else if firstSegment == 0 && secondSegment == 2{convertFromBinToDecimal(binaryNumber: numberToConvert)}
        else if firstSegment == 0 && secondSegment == 3{convertFromBinToHex(binaryNumber: numberToConvert)}
        else if firstSegment == 1 && secondSegment == 0{label.text = convertFromOctalToBin(octal: numberToConvert)}
        else if firstSegment == 1 && secondSegment == 2{convertFromOctalToDecimal(octal: numberToConvert)}
        else if firstSegment == 1 && secondSegment == 3{let bin = convertFromOctalToBin(octal: numberToConvert)
        convertFromBinToHex(binaryNumber: bin)}
        else if firstSegment == 2 && secondSegment == 0{convertFromDecimalToBin(decimal: numberToConvert)}
        else if firstSegment == 2 && secondSegment == 1{convertFromDecimalToOctal(decimal: numberToConvert)}
        else if firstSegment == 2 && secondSegment == 3{convertFromDecimalToHex(decimal: numberToConvert)}
        else if firstSegment == 3 && secondSegment == 0{label.text = convertFromHexToBin(hex: numberToConvert)}
        else if firstSegment == 3 && secondSegment == 1{let bin = convertFromHexToBin(hex: numberToConvert)
            convertFromBinToOctal(binaryNumber: bin)
        }
        else if firstSegment == 3 && secondSegment == 2{convertFromHexToDecimal(hex: numberToConvert)}
    }
}



// MARK: convert functions
extension ViewController{
    
    func convertFromBinToOctal(binaryNumber: String){
        if binaryNumber.contains("."){
            var countOfDot = 0
            let checking = Array(binaryNumber)
            for i in checking{
                if i == "."{
                    countOfDot+=1
                }
            }
            if countOfDot == 1{
                let  str = binaryNumber.split(separator: ".")
                var result1 = ""
                var result2 = ""
                var binaryString1 = ""
                var binaryString2 = ""
                let characters1 = Array(str[0])
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" else {return label.text = "wrong number"}
                }
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" else {return label.text = "wrong number"}
                }
                binaryString1 = "\(complementToOctal(binary: String(str[0])))\(str[0])"
                binaryString2 = "\(str[1])\(complementToOctal(binary: String(str[1])))"
                let octalBinary1 = binaryString1.components(withLength: 3)
                let octalBinary2 = binaryString2.components(withLength: 3)
                for k in 0..<octalBinary1.count{
                    result1 += numerationFromBinToOctal(binary: octalBinary1[k])
                }
                for l in 0..<octalBinary2.count{
                    result2 += numerationFromBinToOctal(binary: octalBinary2[l])
                }
                label.text = "\(result1).\(result2)"
                
            }
            else if countOfDot > 1{
                label.text = "wrong number"
            }
        }
        else{
            var result = ""
            var binaryString = ""
            var characters = Array(binaryNumber)
            for i in 0..<characters.count{
                guard characters[i] == "0" || characters[i] == "1" else {return label.text = "wrong number"}
            }
            binaryString = "\(complementToOctal(binary: binaryNumber))\(binaryNumber)"
            characters = Array(binaryString)
            let octalBinary = binaryString.components(withLength: 3)
            for z in 0..<octalBinary.count{
                result += numerationFromBinToOctal(binary: octalBinary[z])
            }
            label.text = result
        }
    }
    
    func convertFromBinToDecimal(binaryNumber: String){
        if binaryNumber.contains("."){
            var countOfDot = 0
            let checking = Array(binaryNumber)
            for i in checking{
                if i == "."{
                    countOfDot+=1
                }
            }
            if countOfDot == 1{
                var convertedNumber = ""
                var str = binaryNumber.split(separator: ".")
                var result = 0
                var result2 = 0.0
                let reversed = String(str[0].reversed())
                let characters = Array(reversed)
                for i in 0..<characters.count{
                    if characters[i] == "0" || characters[i] == "1"{
                        let power = Int(pow(2, Double(i)))
                        let binNumber = characters[i].wholeNumberValue
                        result = result + Int(power * binNumber!)
                    }
                    else if characters[i] != "0" || characters[i] != "1"{
                        str[1] = "2"
                        break
                    }
                }
                let charactersAfterDot = Array(str[1])
                for j in 0..<charactersAfterDot.count{
                    if charactersAfterDot[j] == "0" || charactersAfterDot[j] == "1"{
                        let power = Double(pow(2, -Double(j+1)))
                        let binNumber = Double(charactersAfterDot[j].wholeNumberValue ?? 0)
                        result2 = result2 + Double(power * binNumber)
                        let finalResult = Double(result) + result2
                        convertedNumber = String(finalResult)
                        label.text = convertedNumber
                    }
                    else if charactersAfterDot[j] != "0" || charactersAfterDot[j] != "1"{
                        label.text = "wrong number"
                        break
                    }
                }
            }
            else{
                label.text = "wrong number"
            }
        }
        else{
            var result = 0
            let reversed = String(binaryNumber.reversed())
            let characters = Array(reversed)
            for i in 0..<characters.count{
                if characters[i] == "0" || characters[i] == "1"{
                    let power = Int(pow(2, Double(i)))
                    let binNumber = characters[i].wholeNumberValue
                    result = result + Int(power * binNumber!)
                    label.text = String(result)
                }
                else if characters[i] != "0" || characters[i] != "1"{
                    label.text = "wrong number"
                    break
                }
            }
        }
    }
    
    func convertFromBinToHex(binaryNumber: String){
        if binaryNumber.contains("."){
            var countOfDot = 0
            let checking = Array(binaryNumber)
            for i in checking{
                if i == "."{
                    countOfDot+=1
                }
            }
            if countOfDot == 1{
                let str = binaryNumber.split(separator: ".")
                var result1 = ""
                var result2 = ""
                var binaryString1 = ""
                var binaryString2 = ""
                let characters1 = Array(str[0])
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" else {return label.text = "wrong number"}
                }
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" else {return label.text = "wrong number"}
                }
                binaryString1 = "\(complementToHex(binary: String(str[0])))\(str[0])"
                binaryString2 = "\(str[1])\(complementToHex(binary: String(str[1])))"
                let hexBinary1 = binaryString1.components(withLength: 4)
                let hexBinary2 = binaryString2.components(withLength: 4)
                for k in 0..<hexBinary1.count{
                    result1 += numerationFromBinToHex(binary: hexBinary1[k])
                }
                for l in 0..<hexBinary2.count{
                    result2 += numerationFromBinToHex(binary: hexBinary2[l])
                }
                label.text = "\(result1).\(result2)"
            }
            else {
                label.text = "wrong number"
            }
            
        }else {
            var result = ""
            var binaryString = ""
            var characters = Array(binaryNumber)
            for i in 0..<characters.count{
                guard characters[i] == "0" || characters[i] == "1" else {return label.text = "wrong number"}
            }
            binaryString = "\(complementToHex(binary: binaryNumber))\(binaryNumber)"
            characters = Array(binaryString)
            let hexBinary = binaryString.components(withLength: 4)
            for z in 0..<hexBinary.count{
                result += numerationFromBinToHex(binary: hexBinary[z])
            }
            label.text = result
            
        }
    }
    //MARK: From octal
    func convertFromOctalToBin(octal: String) -> String{
        var finalResult = "wrong number"
        if octal.contains("."){
            var countOfDot = 0
            let checking = Array(octal)
            for i in checking{
                if i == "."{
                    countOfDot+=1
                }
            }
            if countOfDot == 1{
                var result1 = ""
                var result2 = ""
                let str = octal.split(separator: ".")
                let characters1 = Array(str[0])
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" || characters1[i] == "2" ||
                            characters1[i] == "3" || characters1[i] == "4" || characters1[i] == "5" ||
                            characters1[i] == "6" || characters1[i] == "7" else {return finalResult}
                    result1.append(numerationFromOctalToBin(octal: String(characters1[i])))
                }
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" || characters2[j] == "2" ||
                            characters2[j] == "3" || characters2[j] == "4" || characters2[j] == "5" ||
                            characters2[j] == "6" || characters2[j] == "7" else {return finalResult }
                    result2.append(numerationFromOctalToBin(octal: String(characters2[j])))
                  
                }
                return "\(result1).\(result2)"
            }
            else{
                finalResult = "wrong number"
            }
        }
        else {
            var result = ""
            let characters = Array(octal)
            for i in 0..<characters.count{
                guard characters[i] == "0" || characters[i] == "1" || characters[i] == "2" ||
                        characters[i] == "3" || characters[i] == "4" || characters[i] == "5" ||
                        characters[i] == "6" || characters[i] == "7" else {return finalResult }
                result.append(numerationFromOctalToBin(octal: String(characters[i])))
            }
            finalResult = result
        }
        return finalResult
    }
    func convertFromOctalToDecimal(octal: String){
        if octal.contains("."){
            var countOfDot = 0
            let checking = Array(octal)
            for i in checking{
                if i == "."{
                    countOfDot+=1
                }
            }
            if countOfDot == 1{
                var result1 = 0
                var result2 = 0.0
                let str = octal.split(separator: ".")
                let characters1 = Array(str[0].reversed())
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" || characters1[i] == "2" ||
                    characters1[i] == "3" || characters1[i] == "4" || characters1[i] == "5" ||
                    characters1[i] == "6" || characters1[i] == "7" else {return label.text = "wrong number"}
                    let power = Int(pow(8, Double(i)))
                    let octalNumber = characters1[i].wholeNumberValue
                    result1 = result1 + Int(power * octalNumber!)
                }
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" || characters2[j] == "2" ||
                    characters2[j] == "3" || characters2[j] == "4" || characters2[j] == "5" ||
                    characters2[j] == "6" || characters2[j] == "7" else {return label.text = "wrong number"}
                    let power = Double(pow(8, -Double(j+1)))
                    let octalNumber = Double(characters2[j].wholeNumberValue ?? 0)
                    result2 = result2 + Double(power * octalNumber)

                }
                let finalResult = Double(result1) + result2
                label.text  = String(finalResult)
                
            }
            else{
                label.text = "wrong number"
            }
        }else{
            var result = 0
            let reversed = octal.reversed()
            let characters = Array(reversed)
            for i in 0..<characters.count{
                guard characters[i] == "0" || characters[i] == "1" || characters[i] == "2" ||
                characters[i] == "3" || characters[i] == "4" || characters[i] == "5" ||
                characters[i] == "6" || characters[i] == "7" else {return label.text = "wrong number"}
                let power = Int(pow(8, Double(i)))
                let octalNumber = characters[i].wholeNumberValue
                result = result + Int(power * octalNumber!)
                label.text = String(result)
                
            }
        }
    }
    //MARK: From decimal
    func convertFromDecimalToBin(decimal: String){
        var result = ""
        var binNumber : Int = 0
        var decimalInteger: Int = 0
        if decimal.contains("."){
            var countOfDot = 0
            let checking = Array(decimal)
            for i in checking{
                if i == "."{
                    countOfDot += 1
                }
            }
            if countOfDot == 1 {
                var result1 = ""
                var result2 = ""
                let str = decimal.split(separator: ".")
                let characters1 = Array(str[0])
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" || characters1[i] == "2" ||
                            characters1[i] == "3" || characters1[i] == "4" || characters1[i] == "5" ||
                            characters1[i] == "6" || characters1[i] == "7" || characters1[i] == "8" ||
                            characters1[i] == "9" else {return label.text = "wrong number"}}
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" || characters2[j] == "2" ||
                            characters2[j] == "3" || characters2[j] == "4" || characters2[j] == "5" ||
                            characters2[j] == "6" || characters2[j] == "7" || characters2[j] == "8" ||
                            characters2[j] == "9" else {return label.text = "wrong number"}}
                    decimalInteger = Int(str[0])!
                    while decimalInteger > 0{
                        binNumber = decimalInteger % 2
                        result1 = String(binNumber) + result1
                        decimalInteger = Int(decimalInteger / 2)
                    }
                if str[0] == "0"{
                    result1 = "0"
                }
                    let num = Double(decimal)
                    var fractional = num?.truncatingRemainder(dividingBy: 1)
                        while fractional != 0{
                            fractional = Double(fractional! * 2)
                            result2.append(String(Int(fractional!)))
                            fractional = Double(fractional!) - Double(Int(fractional!))
                            if result2.count == 15{
                                fractional = 0
                                result2.append("...")
                            }
                        }
                label.text = result1 + "." + result2
            }
            else{
                label.text = "wrong number"
            }
        }
        else{
            if decimal.isNumber{
                decimalInteger = Int(decimal)!
                while decimalInteger > 0 {
                    binNumber = decimalInteger % 2
                    result = String(binNumber) + result
                    decimalInteger = Int(decimalInteger / 2)
                }
                label.text = String(result)
            }
            else {
                label.text = "wrong number"
            }
        }
        
    }
    func convertFromDecimalToOctal(decimal: String){
        var result = ""
        var octalNumber : Int = 0
        var decimalInteger: Int = 0
        if decimal.contains("."){
            var countOfDot = 0
            let checking = Array(decimal)
            for i in checking{
                if i == "."{
                    countOfDot += 1
                }
                
            }
            if countOfDot == 1 {
                var result1 = ""
                var result2 = ""
                let str = decimal.split(separator: ".")
                let characters1 = Array(str[0])
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" || characters1[i] == "2" ||
                            characters1[i] == "3" || characters1[i] == "4" || characters1[i] == "5" ||
                            characters1[i] == "6" || characters1[i] == "7" || characters1[i] == "8" ||
                            characters1[i] == "9" else {return label.text = "wrong number"}}
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" || characters2[j] == "2" ||
                            characters2[j] == "3" || characters2[j] == "4" || characters2[j] == "5" ||
                            characters2[j] == "6" || characters2[j] == "7" || characters2[j] == "8" ||
                            characters2[j] == "9" else {return label.text = "wrong number"}}
                    decimalInteger = Int(str[0])!
                    while decimalInteger > 0{
                        octalNumber = decimalInteger % 8
                        result1 = String(octalNumber) + result1
                        decimalInteger = Int(decimalInteger / 8)
                    }
                if str[0] == "0"{
                    result1 = "0"
                }
                let num = Double(decimal)
                var fractional = num?.truncatingRemainder(dividingBy: 1)
                    while fractional != 0{
                        fractional = Double(fractional! * 8)
                        result2.append(String(Int(fractional!)))
                        fractional = Double(fractional!) - Double(Int(fractional!))
                        if result2.count == 15{
                            fractional = 0
                            result2.append("...")
                        }
                    }
                label.text = result1 + "." + result2
                }
                
            else{
                label.text = "wrong number"
            }
        }
        else{
            if decimal.isNumber{
                decimalInteger = Int(decimal)!
                while decimalInteger > 0 {
                    octalNumber = decimalInteger % 8
                    result = String(octalNumber) + result
                    decimalInteger = Int(decimalInteger / 8)
                    label.text = String(result)
                }
            }
            else {
                label.text = "wrong number"
            }
            
            
        }
    }
    func convertFromDecimalToHex(decimal: String){
        var result = ""
        var hexNumber : Int = 0
        var decimalInteger: Int = 0
        if decimal.contains("."){
            var countOfDot = 0
            let checking = Array(decimal)
            for i in checking{
                if i == "."{
                    countOfDot += 1
                }
                
            }
            if countOfDot == 1 {
                var result1 = ""
                var result2 = ""
                let str = decimal.split(separator: ".")
                let characters1 = Array(str[0])
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" || characters1[i] == "2" ||
                            characters1[i] == "3" || characters1[i] == "4" || characters1[i] == "5" ||
                            characters1[i] == "6" || characters1[i] == "7" || characters1[i] == "8" ||
                            characters1[i] == "9" else {return label.text = "wrong number"}}
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" || characters2[j] == "2" ||
                            characters2[j] == "3" || characters2[j] == "4" || characters2[j] == "5" ||
                            characters2[j] == "6" || characters2[j] == "7" || characters2[j] == "8" ||
                            characters2[j] == "9" else {return label.text = "wrong number"}}
                    decimalInteger = Int(str[0])!
                    while decimalInteger > 0{
                        hexNumber = decimalInteger % 16
                        result1 = numerationFromDecimalToHex(decimal: String(hexNumber)) + result1
                        decimalInteger = Int(decimalInteger / 16)
                    }
                if str[0] == "0"{
                    result1 = "0"
                }
                let num = Double(decimal)
                var fractional = num?.truncatingRemainder(dividingBy: 1)
                    while fractional != 0{
                        fractional = Double(fractional! * 16)
                        result2.append(numerationFromDecimalToHex(decimal: (String(Int(fractional!)))))
                        fractional = Double(fractional!) - Double(Int(fractional!))
                        if result2.count == 10{
                            fractional = 0
                            result2.append("...")
                        }
                    }
                label.text = result1 + "." + result2
            }
            else{
                label.text = "wrong number"
            }
        }
        else{
            if decimal.isNumber{
                decimalInteger = Int(decimal)!
                while decimalInteger > 0 {
                    hexNumber = decimalInteger % 16
                    result = numerationFromDecimalToHex(decimal: String(hexNumber)) + result
                    decimalInteger = Int(decimalInteger / 16)
                    label.text = String(result)
                }
            }
            else {
                label.text = "wrong number"
            }
            
            
        }
    }
    
    //MARK: From hex
    func convertFromHexToBin(hex: String) -> String{
        var finalResult = "wrong number"
        if hex.contains("."){
            var countOfDot = 0
            let checking = Array(hex)
            for i in checking{
                if i == "."{
                    countOfDot+=1
                }
            }
            if countOfDot == 1{
                var result1 = ""
                var result2 = ""
                let str = hex.split(separator: ".")
                let characters1 = Array(str[0])
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" || characters1[i] == "2" ||
                    characters1[i] == "3" || characters1[i] == "4" || characters1[i] == "5" ||
                    characters1[i] == "6" || characters1[i] == "7" || characters1[i] == "8" ||
                    characters1[i] == "9" || characters1[i] == "A" || characters1[i] == "B" ||
                    characters1[i] == "C" || characters1[i] == "D" || characters1[i] == "E" ||
                    characters1[i] == "F" else {return finalResult}
                    result1 = result1 + numerationFromHexToBin(hex: String(characters1[i]))
                }
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" || characters2[j] == "2" ||
                    characters2[j] == "3" || characters2[j] == "4" || characters2[j] == "5" ||
                    characters2[j] == "6" || characters2[j] == "7" || characters2[j] == "8" ||
                    characters2[j] == "9" || characters2[j] == "A" || characters2[j] == "B" ||
                    characters2[j] == "C" || characters2[j] == "D" || characters2[j] == "E" ||
                    characters2[j] == "F" else {return finalResult}
                    result2 = result2 + numerationFromHexToBin(hex: String(characters2[j]))
                }
                finalResult = "\(result1).\(result2)"
                
            }
            else{
                finalResult = "wrong number"
            }
        }
        else{
            var result = ""
            let characters = Array(hex)
            for i in 0..<characters.count{
                guard characters[i] == "0" || characters[i] == "1" || characters[i] == "2" ||
                characters[i] == "3" || characters[i] == "4" || characters[i] == "5" ||
                characters[i] == "6" || characters[i] == "7" || characters[i] == "8" ||
                characters[i] == "9" || characters[i] == "A" || characters[i] == "B" ||
                characters[i] == "C" || characters[i] == "D" || characters[i] == "E" ||
                characters[i] == "F" else {return finalResult}
                result = result + numerationFromHexToBin(hex: String(characters[i]))
            }
            finalResult = result
        }
        return finalResult
    }
    func convertFromHexToDecimal(hex: String){
        if hex.contains("."){
            var countOfDot = 0
            let checking = Array(hex)
            for i in checking{
                if i == "."{
                    countOfDot+=1
                }
            }
            if countOfDot == 1{
                var result1 = 0
                var result2 = 0.0
                let str = hex.split(separator: ".")
                let characters1 = Array(str[0].reversed())
                let characters2 = Array(str[1])
                for i in 0..<characters1.count{
                    guard characters1[i] == "0" || characters1[i] == "1" || characters1 [i] == "2" ||
                    characters1[i] == "3" || characters1[i] == "4" || characters1[i] == "5" ||
                    characters1[i] == "6" || characters1[i] == "7" || characters1[i] == "8" ||
                    characters1[i] == "9" || characters1[i] == "A" || characters1[i] == "B" ||
                    characters1[i] == "C" || characters1[i] == "D" || characters1[i] == "E" ||
                    characters1[i] == "F" else {return label.text = "wrong number"}
                    let character = numerationFromHexToDecimal(hex: String(characters1[i]))
                    let power = Int(pow(16, Double(i)))
                    let hexNumber = Int(character)
                    result1 = result1 + Int(power * hexNumber!)
                }
                for j in 0..<characters2.count{
                    guard characters2[j] == "0" || characters2[j] == "1" || characters2[j] == "2" ||
                    characters2[j] == "3" || characters2[j] == "4" || characters2[j] == "5" ||
                    characters2[j] == "6" || characters2[j] == "7" || characters2[j] == "8" ||
                    characters2[j] == "9" || characters2[j] == "A" || characters2[j] == "B" ||
                    characters2[j] == "C" || characters2[j] == "D" || characters2[j] == "E" ||
                    characters2[j] == "F" else {return label.text = "wrong number"}
                    let character = numerationFromHexToDecimal(hex: String(characters2[j]))
                    let power = Double(pow(16, -Double(j+1)))
                    let hexNumber = Double(character)
                    result2 = result2 + Double(power * hexNumber!)
                }
                let finalResult = Double(result1) + result2
                label.text = String(finalResult)
            }
            else{
                label.text = "wrong number"
            }
        }
        else{
            var result = 0
            let reversed = hex.reversed()
            let characters = Array(reversed)
            for i in 0..<characters.count{
                guard characters[i] == "0" || characters[i] == "1" || characters[i] == "2" ||
                characters[i] == "3" || characters[i] == "4" || characters[i] == "5" ||
                characters[i] == "6" || characters[i] == "7" || characters[i] == "8" ||
                characters[i] == "9" || characters[i] == "A" || characters[i] == "B" ||
                characters[i] == "C" || characters[i] == "D" || characters[i] == "E" ||
                characters[i] == "F" else {return label.text = "wrong number"}
                let character = numerationFromHexToDecimal(hex: String(characters[i]))
                let power = Int(pow(16, Double(i)))
                let hexNumber = Int(character)
                result = result + Int(power * hexNumber!)
                label.text = String(result)
                
            }
            
        }
    }
    
    func complementToHex(binary: String) -> String{
        let characters = Array(binary)
        let remains = characters.count % 4
        var str = ""
        for _ in 0..<(4-remains){
            str.append("0")
        }
        if remains == 0{
            str = ""
        }
        return str
    }
    
    func complementToOctal(binary: String) -> String{
        let characters = Array(binary)
        let remains = characters.count % 3
        var str = ""
        for _ in 0..<(3-remains){
            str.append("0")
        }
        if remains == 0{
            str = ""
        }
        return str
    }
    func numerationFromBinToHex(binary: String) -> String{
        var hex = ""
        switch binary{
        case "0000": hex = "0"
        case "0001": hex = "1"
        case "0010": hex = "2"
        case "0011": hex = "3"
        case "0100": hex = "4"
        case "0101": hex = "5"
        case "0110": hex = "6"
        case "0111": hex = "7"
        case "1000": hex = "8"
        case "1001": hex = "9"
        case "1010": hex = "A"
        case "1011": hex = "B"
        case "1100": hex = "C"
        case "1101": hex = "D"
        case "1110": hex = "E"
        case "1111": hex = "F"
        default:
            break
        }
        return hex
    }
    func numerationFromBinToOctal(binary: String) -> String{
        var octal = ""
        switch binary{
        case "000": octal = "0"
        case "001": octal = "1"
        case "010": octal = "2"
        case "011": octal = "3"
        case "100": octal = "4"
        case "101": octal = "5"
        case "110": octal = "6"
        case "111": octal = "7"
        default:
            break
        }
        return octal
    }
    
    func numerationFromOctalToBin(octal: String) -> String{
        var binary = ""
        switch octal{
        case "0": binary = "000"
        case "1": binary = "001"
        case "2": binary = "010"
        case "3": binary = "011"
        case "4": binary = "100"
        case "5": binary = "101"
        case "6": binary = "110"
        case "7": binary = "111"
        default: break
        }
        return binary
    }
    func numerationFromHexToBin(hex: String) -> String{
        var binary = ""
        switch hex{
        case "0": binary = "0000"
        case "1": binary = "0001"
        case "2": binary = "0010"
        case "3": binary = "0011"
        case "4": binary = "0100"
        case "5": binary = "0101"
        case "6": binary = "0110"
        case "7": binary = "0111"
        case "8": binary = "1000"
        case "9": binary = "1001"
        case "A": binary = "1010"
        case "B": binary = "1011"
        case "C": binary = "1100"
        case "D": binary = "1101"
        case "E": binary = "1110"
        case "F": binary = "1111"
        default: break
        }
        return binary
    }
    func numerationFromHexToDecimal(hex: String) -> String{
        var decimal = ""
        switch hex{
        case "0": decimal = "0"
        case "1": decimal = "1"
        case "2": decimal = "2"
        case "3": decimal = "3"
        case "4": decimal = "4"
        case "5": decimal = "5"
        case "6": decimal = "6"
        case "7": decimal = "7"
        case "8": decimal = "8"
        case "9": decimal = "9"
        case "A": decimal = "10"
        case "B": decimal = "11"
        case "C": decimal = "12"
        case "D": decimal = "13"
        case "E": decimal = "14"
        case "F": decimal = "15"
        default: break
        }
        return decimal
    }
    
    func numerationFromDecimalToHex(decimal: String) -> String{
        var hex = ""
        switch decimal{
        case "0": hex = "0"
        case "1": hex = "1"
        case "2": hex = "2"
        case "3": hex = "3"
        case "4": hex = "4"
        case "5": hex = "5"
        case "6": hex = "6"
        case "7": hex = "7"
        case "8": hex = "8"
        case "9": hex = "9"
        case "10": hex = "A"
        case "11": hex = "B"
        case "12": hex = "C"
        case "13": hex = "D"
        case "14": hex = "E"
        case "15": hex = "F"
        default: break
        }
        return hex
    }
    
}
// MARK: additional func for STRING
extension String {
    func components(withLength length: Int) -> [String] {
        return stride(from:0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start ..< end])
        }
    }
    var isNumber: Bool {
        return self.allSatisfy { character in
            character.isWholeNumber
        }
    }
}

extension Double{
    var integerPart: Double {
        return Double(Int(self))
    }
}
