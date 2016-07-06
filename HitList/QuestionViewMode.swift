//
//  QuestionViewMode.swift
//  HitList
//
//  Created by Kacper Augustyniak on 01/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import UIKit
import CoreData

class QuestionViewMode: NSObject {
  weak var delegate:QuestionViewController?
  
  func shouldShowHelp(question:Question) {
  }
  
  func lastQuestionAnswered(){
    print("no lastQuestionAnswered implementation")
  }
  
  func answerWasCorrect(){
  }
  func answerWasWrong(){
  }
}
class QuestionViewModeTest: QuestionViewMode {
 
  var correctAnswerCount:Int = 0
  var wrongAnswerCount:Int = 0
  var timer:NSTimer!
  
  override init() {
    super.init()
    timer = NSTimer.scheduledTimerWithTimeInterval(3600.0, target: self, selector: #selector(QuestionViewModeTest.timerDidCountDown), userInfo: nil, repeats: false)
  }
  
  func timerDidCountDown(){
    let alert = UIAlertController(title: "Times Up!", message: "Your result - \(100*correctAnswerCount/(self.delegate?.questionsIndexes.count)!)% ", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
      self.delegate?.navigationController?.popViewControllerAnimated(true)
    })
    
    alert.addAction(cancelAction)
    
    delegate?.presentViewController(alert, animated: true, completion: nil)
  }
  
  override func shouldShowHelp(question:Question) {

      delegate?.onlineDocButton.hidden = true
      delegate?.explanationButton.hidden = true
      delegate?.redoQuestionButton.hidden = true
      delegate?.onlineDocButton2.hidden = true
    }
  
  override func answerWasCorrect(){
    correctAnswerCount += 1
  }
  override func answerWasWrong(){
    wrongAnswerCount += 1
  }
  override func lastQuestionAnswered(){
    
    let seconds = Int(timer.fireDate.timeIntervalSinceNow)%60
    let minutes = Int(floor(timer.fireDate.timeIntervalSinceNow/60))
    
    let alert = UIAlertController(title: "Finished", message: "Your result - \(100*correctAnswerCount/(wrongAnswerCount+correctAnswerCount))% \n Time left \(minutes):\(seconds)", preferredStyle: UIAlertControllerStyle.Alert)
    
    timer.invalidate()
    
    let cancelAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
      self.delegate?.navigationController?.popViewControllerAnimated(true)
    })
    
    alert.addAction(cancelAction)
    
    delegate?.presentViewController(alert, animated: true, completion: nil)
    
  }
}
class QuestionViewModeFree: QuestionViewMode {
  
  override func shouldShowHelp(question:Question) {
    if let url =  question.helpUrl {
      delegate?.onlineDocButton.hidden = false
      delegate?.onlineDocButton2.hidden = false
      delegate?.helpUrl = url
    }
    if let explanation = question.explanation {
      delegate?.explanationButton.hidden = false
      delegate?.explanation = explanation
    }
    delegate?.redoQuestionButton.hidden = false
  }
  
  override func lastQuestionAnswered(){
    let alert = UIAlertController(title: "All questions answred", message: "Do you want to start over", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
      self.delegate?.navigationController?.popViewControllerAnimated(true)
    })
    
    let resetAction = UIAlertAction(title: "Reset", style: .Default, handler: { (action: UIAlertAction!) in
      self.delegate?.resetQuestionIndex()
    })
    
    
    alert.addAction(cancelAction)
    alert.addAction(resetAction)
    
    delegate?.presentViewController(alert, animated: true, completion: nil)

  }
  
}