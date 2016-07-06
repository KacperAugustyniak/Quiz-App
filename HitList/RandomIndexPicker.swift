//
//  RandomIndexPicker.swift
//  HitList
//
//  Created by Kacper Augustyniak on 27/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import Foundation

class RandomIndexPicker {

  static func pickRandomElementsIndexes(numOfElements:Int, range:Int) -> Array<Int>?{
  
  var uniqueNumbers = Set<Int>()
// var returnArray = Array<Int>()
  while uniqueNumbers.count < numOfElements {
    //let randomNum = Int(arc4random_uniform(UInt32(numOfElements) ))
    let randomNum = Int(arc4random_uniform(UInt32(range) ))
    uniqueNumbers.insert(randomNum)
  }
  
//  for number in uniqueNumbers {
//    returnArray.append(number)
//  }
//  
//  return returnArray
  return Array(uniqueNumbers)
  }
}