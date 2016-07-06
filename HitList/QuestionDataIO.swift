//
//  QuestionDataIO.swift
//  HitList
//
//  Created by Kacper Augustyniak on 17/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct AnswerStruct {
  var text:String
  var isTrue:Bool
}

class QuestionDataIO {
  
  var questions = [NSManagedObject]()
  var answers = [NSManagedObject]()
  
///////////////////////////////////////////////////////////////////////////////////////////
  func doStuff(){
    let question = "Is it?"
    var tempAnswers:Array<AnswerStruct> = []
    
    tempAnswers.append(AnswerStruct(text: "YES", isTrue: false))
      
    tempAnswers.append(AnswerStruct(text: "NO", isTrue: true))
    
    self.saveQuestion(question, with: tempAnswers)
    self.loadQuestion(0)
    self.loadQuestion(1)
  }
//////////////////////////////////////////////////////////////////////////////////////////
  func getNumberOfQuestions() -> Int {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName: "Question")
    
    return managedContext.countForFetchRequest(fetchRequest, error: nil)
    
  }
  
  func loadQuestion(index:Int) -> (question:Question,answers:NSOrderedSet){
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName: "Question")
    
    do {
      let results =
        try managedContext.executeFetchRequest(fetchRequest)
      questions = results as! [Question]
  
    } catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }
    let question0 = questions[index] as! Question
    
    let answers = question0.qARelation //as! Set<Answer>
    
//    for answer in answers! {
//      let temp = answer as! Answer
//      //print("answ \(temp.text) and is \(temp.isCorrect)")
//    }
    return (question0, answers!)
  }
  
  func saveQuestion(question: String, with questionAnswers:Array<AnswerStruct>) {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    let entityQuestion =  NSEntityDescription.entityForName("Question", inManagedObjectContext:managedContext)
    
    let tempQuestion = NSManagedObject(entity: entityQuestion!, insertIntoManagedObjectContext: managedContext)
    tempQuestion.setValue(question, forKey: "text")
    do {
      try managedContext.save()
    } catch let error as NSError  {
      print("Could not save question \(error), \(error.userInfo)")
    }
    
    for answer in questionAnswers {
      
      let managedContext = appDelegate.managedObjectContext
      let entityAnswer =  NSEntityDescription.entityForName("Answer", inManagedObjectContext:managedContext)
      
      let tempAnswer = NSManagedObject(entity: entityAnswer!, insertIntoManagedObjectContext: managedContext)
      tempAnswer.setValue(answer.isTrue, forKey: "isCorrect")
      tempAnswer.setValue(answer.text, forKey: "text")
      tempAnswer.setValue(tempQuestion, forKey: "aQRelation")
      do {
        try managedContext.save()
      } catch let error as NSError  {
        print("Could not save answer \(error), \(error.userInfo)")
      }
      
    }
  }
  
  func saveQuestion(question: String, answers questionAnswers:Array<AnswerStruct>, explanation:String?, url:String?) {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    let entityQuestion =  NSEntityDescription.entityForName("Question", inManagedObjectContext:managedContext)
    
    let tempQuestion = NSManagedObject(entity: entityQuestion!, insertIntoManagedObjectContext: managedContext)
    tempQuestion.setValue(question, forKey: "text")

    
    if let unwrappedExplanation = explanation {
      tempQuestion.setValue(unwrappedExplanation, forKey: "explanation")
    }
    
    if let unwrappedUrl = url {
      tempQuestion.setValue(unwrappedUrl, forKey: "helpUrl")
    }
    
    do {
      try managedContext.save()
    } catch let error as NSError  {
      print("Could not save question \(error), \(error.userInfo)")
    }
    
    for answer in questionAnswers {
      
      let managedContext = appDelegate.managedObjectContext
      let entityAnswer =  NSEntityDescription.entityForName("Answer", inManagedObjectContext:managedContext)
      
      let tempAnswer = NSManagedObject(entity: entityAnswer!, insertIntoManagedObjectContext: managedContext)
      tempAnswer.setValue(answer.isTrue, forKey: "isCorrect")
      tempAnswer.setValue(answer.text, forKey: "text")
      tempAnswer.setValue(tempQuestion, forKey: "aQRelation")
      do {
        try managedContext.save()
      } catch let error as NSError  {
        print("Could not save answer \(error), \(error.userInfo)")
      }
      
    }
  }

  
}
