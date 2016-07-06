//
//  QuestionLoader.swift
//  HitList
//
//  Created by Kacper Augustyniak on 27/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import Foundation
import CoreData

class QuestionLoader {
  
  func loadQuestions(){
    let veryTemp = QuestionDataIO()
    // MARK: Question 0
    var question = "What is the capilat of Australia?"
    var tempAnswers:Array<AnswerStruct> = []
    tempAnswers.append(AnswerStruct(text: "Sydney", isTrue: false))
    tempAnswers.append(AnswerStruct(text: "Canberra", isTrue: true))
    tempAnswers.append(AnswerStruct(text: "Melbourne", isTrue: false))
    tempAnswers.append(AnswerStruct(text: "Newcastle", isTrue: false))
    
    veryTemp.saveQuestion(question, answers: tempAnswers, explanation: nil, url: "https://en.wikipedia.org/wiki/Australia")
    // MARK: Question 1
    question = "Which of the followning belongs to hymenoptera order?"
    tempAnswers.removeAll()
    tempAnswers.append(AnswerStruct(text: "Annam walking stick", isTrue: false))
    tempAnswers.append(AnswerStruct(text: "Honey bee", isTrue: true))
    tempAnswers.append(AnswerStruct(text: "Weaver ant", isTrue: true))
    tempAnswers.append(AnswerStruct(text: "European mole cricket", isTrue: false))
    
    veryTemp.saveQuestion(question, answers: tempAnswers, explanation: "Hymenoptera is the third-largest order of insects, comprising the sawflies, wasps, bees, and ants.", url: "https://en.wikipedia.org/wiki/Hymenoptera")
    
    // MARK: Question 2
    question = "What is pirate flag called?"
    tempAnswers.removeAll()
    tempAnswers.append(AnswerStruct(text: "Union Jack", isTrue: false))
    tempAnswers.append(AnswerStruct(text: "Jolly Roger", isTrue: true))
    tempAnswers.append(AnswerStruct(text: "Hill Billy", isTrue: false))
    
    veryTemp.saveQuestion(question, answers: tempAnswers, explanation: "Jolly Roger is the traditional English name for the flags flown to identify a pirate ship about to attack during the early 18th century (i.e. the later part of the \"Golden Age of Piracy\").", url: "https://en.wikipedia.org/wiki/Jolly_Roger")
    
    // MARK: Question 3
    question = "Which of the followning has no moon?"
    tempAnswers.removeAll()
    tempAnswers.append(AnswerStruct(text: "Mars", isTrue: false))
    tempAnswers.append(AnswerStruct(text: "Mercury", isTrue: true))
    tempAnswers.append(AnswerStruct(text: "Venus", isTrue: true))
    tempAnswers.append(AnswerStruct(text: "Uranus", isTrue: false))
    
    veryTemp.saveQuestion(question, answers: tempAnswers, explanation: "", url: "https://en.wikipedia.org/wiki/List_of_natural_satellites")
    
    
    
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "notFirstTimeAppLaunch")

  }
}
