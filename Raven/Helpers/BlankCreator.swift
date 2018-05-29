//
//  BlankCreator.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import Foundation

class BlankCreator {
    
    // MARK: - Properties
    
    static let shared = BlankCreator()
    
    var textInput: String = ""
    var textInputRaw: String = ""
    
    var originalArr: [SmartString] = []
    var rawArr: [SmartString] = []
    
    var indexHolderArr: [Int] = []
    var shuffledIndexesArr: [Int] = []
    var indexHolderArrCopy: [Int] = []
    
    var wordLengths: [Int] = []
    var numWordIndexes: Int = 0
    
    var percent: Float = 0
    var numWordsToHide: Int = 0
    var numWordsToHideCopy: Int = 0
    
    var selectedRandoms: [Int] = []
    
    var displayArray: [SmartString] = []
    
    var callerStringArr: [String] = []
    
    
    // Mark: - Accessible Methods
    
    func initBlankArrWithRandomization(text: String, percent: Float) -> [String] {
        textInput = text
        return randomizeBlankPositions(percent: percent)
    }
    
    func changeNumBlanks(percent: Float) -> [String] {
        return buildBlanksOnly(percent: percent)
    }
    
    func getNonBlankArray(text: String) -> [String] {
        textInputRaw = text
        rawArr = textInputRaw.buildSmartStringArray()
        var stringArr: [String] = []
        stringArr = rawArr.map { $0.value }
        return removeNewLines(array: stringArr)
    }
    
    
    // MARK: - Methods
    
    func randomizeBlankPositions(percent: Float) -> [String] {
        
        originalArr = textInput.buildSmartStringArray()
        
        indexHolderArr.removeAll()
        shuffledIndexesArr.removeAll()
        indexHolderArrCopy.removeAll()
        selectedRandoms.removeAll()
        
        indexHolderArr = initIndexHolderArray()
        indexHolderArrCopy = indexHolderArr
        numWordIndexes = getWordCount(textArr: originalArr)
        
        for _ in 0..<numWordIndexes {
            
            var random = getRandom(count: indexHolderArrCopy.count)
            
            while originalArr[random].isPunctuation == true || selectedRandoms.contains(random) {
                random = getRandom(count: indexHolderArrCopy.count)
            }
            
            selectedRandoms.append(random)
            
            shuffledIndexesArr.append(indexHolderArrCopy[random])
        }
        
        return buildBlanks(percent: percent)
    }
    
    func buildBlanks(percent: Float) -> [String] {
        
        wordLengths.removeAll()
        displayArray.removeAll()
        
        wordLengths = originalArr.map { $0.value.count }
        numWordsToHide = getWordsToHideCount(percent: percent)
        numWordsToHideCopy = numWordsToHide
        displayArray = originalArr
        
        while numWordsToHideCopy != 0 {
            
            let originalIndex = shuffledIndexesArr[numWordsToHide - numWordsToHideCopy]
            let wordLength = wordLengths[originalIndex]
            var blankString = ""
            
            for _ in 0..<wordLength {
                blankString += "_"
            }
            
            numWordsToHideCopy -= 1
            displayArray[originalIndex].value = blankString
        }
        
        return buildDisplayArr(arr: displayArray)
    }
    
    func buildBlanksOnly(percent: Float) -> [String] {
        
        originalArr.removeAll()
        originalArr = textInput.buildSmartStringArray()
        
        wordLengths.removeAll()
        displayArray.removeAll()
        
        wordLengths = originalArr.map { $0.value.count }
        numWordsToHide = getWordsToHideCount(percent: percent)
        numWordsToHideCopy = numWordsToHide
        displayArray = originalArr
        
        while numWordsToHideCopy != 0 {
            
            let originalIndex = shuffledIndexesArr[numWordsToHide - numWordsToHideCopy]
            let wordLength = wordLengths[originalIndex]
            var blankString = ""
            
            for _ in 0..<wordLength {
                blankString += "_"
            }
            
            numWordsToHideCopy -= 1
            displayArray[originalIndex].value = blankString
        }
        
        return buildDisplayArr(arr: displayArray)
    }
    
    func buildDisplayString(displayArr: [SmartString]) -> String {
        
        var displayString = ""
        
        for i in 0..<displayArr.count {
            
            displayString.append(displayArr[i].value)
            
            if (i + 1) != displayArr.count {
                
                if displayArr[i].value == "_" && displayArr[i].isPunctuation == true {
                    displayString.append(" ")
                } else if displayArr[i].value != "_" && displayArr[i].isPunctuation == true {
                    displayString.append(" ")
                } else if displayArray[i + 1].isPunctuation == true  {
                    displayString.append("")
                } else {
                    displayString.append(" ")
                }
            } else {
                continue
            }
        }
        return displayString
    }
    
    
    // MARK: - Helper Methods
    
    func getWordCount(textArr: [SmartString]) -> Int {
        var count = 0
        for word in textArr {
            if word.isPunctuation == false {
                count += 1
            }
        }
        return count
    }
    
    func getWordsToHideCount(percent: Float) -> Int {
        let count = getWordCount(textArr: originalArr)
        let numHiddenWords = Int(Float(count) * percent)
        return numHiddenWords
    }
    
    func initIndexHolderArray() -> [Int] {
        indexHolderArr.removeAll()
        for i in 0..<originalArr.count {
            indexHolderArr.append(i)
        }
        return indexHolderArr
    }
    
    func getRandom(count: Int) -> Int {
        let indexCount = count
        let random = Int(arc4random_uniform(UInt32(indexCount)))
        return random
    }
    
    
    func buildDisplayArr(arr: [SmartString]) -> [String] {
        var stringArr: [String] = []
        stringArr.removeAll()
        
        for i in 0..<arr.count {
            stringArr.append(arr[i].value)
        }
        
        return removeNewLines(array: stringArr)
    }
    
    func removeNewLines(array: [String]) -> [String] {
        var result = array
        for i in 0..<result.count {
            while result[i].contains("\n") {
                let subRange = Range(result[i].startIndex..<result[i].index(result[i].startIndex, offsetBy: 1))
                result[i].removeSubrange(subRange)
            }
        }
        return result
    }
}

/*
 
 print("\n")
 print("--------------------------------------------------- ")
 print("                With Output Strings                 ")
 print("--------------------------------------------------- ")
 print("\n")
 
 print("75% Blanks:")
 callerStringArr = initBlankArrWithRandomization(text: textInput, percent: 0.75)
 callerStringArr = changeNumBlanks(percent: 0.95)
 print("Blanks array: \n\(callerStringArr)")
 print("\n")
 print("Display string: \n\(buildDisplayString(displayArr: displayArray))")
 print("\n")
 
 */
