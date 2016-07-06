////
////  Array+randomElement.swift
////  HitList
////
////  Created by Kacper Augustyniak on 26/06/16.
////  Copyright © 2016 Kacper Augustyniak. All rights reserved.
////
//
//import Foundation
//
//extension Array {
//  func randomItem() -> Element? {
//    
//    if self.isEmpty { return nil }
//    let index = Int(arc4random_uniform(UInt32(self.count)))
//    return self[index]
//  }
//  
//  func randomIndex() -> Int? {
//    
//    if self.isEmpty { return nil }
//    return Int(arc4random_uniform(UInt32(self.count)))
//  }
//}
//
//extension CollectionType {
//  /// Return a copy of `self` with its elements shuffled
//  func shuffle() -> [Generator.Element] {
//    var list = Array(self)
//    list.shuffleInPlace()
//    return list
//  }
//}
//
//extension MutableCollectionType where Index == Int {
//  /// Shuffle the elements of `self` in-place.
//  mutating func shuffleInPlace() {
//    // empty and single-element collections don't shuffle
//    if count < 2 { return }
//    
//    for i in 0..<count - 1 {
//      let j = Int(arc4random_uniform(UInt32(count - i))) + i
//      guard i != j else { continue }
//      swap(&self[i], &self[j])
//    }
//  }
//}