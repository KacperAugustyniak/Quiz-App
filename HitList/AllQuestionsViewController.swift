//
//  AllQuestionsViewController.swift
//  HitList
//
//  Created by Kacper Augustyniak on 30/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import UIKit
import CoreData

class AllQuestionsViewController: UITableViewController {

  var questionObject:QuestionDataIO!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    questionObject = QuestionDataIO()
    //jumpToQuestion(3)
    //tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "AllQuestionViewSegue" {
      let viewController = segue.destinationViewController as! QuestionViewController
      viewController.questionObject = questionObject
      
      var tempQuestionIndexes = Array<Int>()
      
      for index in tableView.indexPathForSelectedRow!.row..<questionObject.getNumberOfQuestions() {
          tempQuestionIndexes.append(index)
        }
    
      for index in 0..<tableView.indexPathForSelectedRow!.row {
        tempQuestionIndexes.append(index)
      }
      viewController.questionsIndexes = tempQuestionIndexes
          viewController.mode = QuestionViewModeFree()

    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return questionObject.getNumberOfQuestions()
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell = UITableViewCell()
    
    var text = ""
  
      cell = tableView.dequeueReusableCellWithIdentifier("QuestionsCell")!
      let questionReturns = questionObject.loadQuestion(indexPath.row)
      text = "Question \(indexPath.row) - \((questionReturns.question.text)!)"
    
    cell.textLabel?.text = text
    cell.textLabel?.numberOfLines = 1
    
    return cell
  }
  
  func jumpToQuestion(questionNo:Int){
    var safeQuestionNo = questionNo
    if !(questionNo < questionObject.getNumberOfQuestions()){
      safeQuestionNo = questionObject.getNumberOfQuestions() - 1
    }
    
    let indexPath = NSIndexPath(forItem: safeQuestionNo, inSection: 0)
    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
  }
  
  @IBAction func jumpToQuestionButtonPressed(sender: AnyObject) {
    showJumpToQuestionAllert()
  }
  
  func showJumpToQuestionAllert () {
    
    let alert = UIAlertController(title: "Jump to question", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in })
    
    let saveAction = UIAlertAction(title: "Go", style: .Default, handler: { (action: UIAlertAction!) in
      let textField = alert.textFields![0] as UITextField
      self.jumpToQuestion(Int(textField.text!)!)
    })
    
    //alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) in }
    
    alert.addAction(cancelAction)
    alert.addAction(saveAction)
    alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
      textField.keyboardType = UIKeyboardType.NumberPad
    }
    self.presentViewController(alert, animated: true, completion: nil)
    
  }
  
}
