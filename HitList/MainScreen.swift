//
//  MainScreen.swift
//  HitList
//
//  Created by Kacper Augustyniak on 26/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import GameplayKit

class MainScreen: UIViewController, UITableViewDataSource,UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "QuestionViewSegue" {
      let questionObject = QuestionDataIO()
      let viewController = segue.destinationViewController as! QuestionViewController
      viewController.questionObject = questionObject
      
      viewController.mode = QuestionViewModeTest()
      
      let indexes = RandomIndexPicker.pickRandomElementsIndexes(3,range:questionObject.getNumberOfQuestions())! //Number of questions in test
      let shuffledIndexes = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(indexes) as! Array<Int>
      viewController.questionsIndexes = shuffledIndexes
      
      //print(RandomIndexPicker.pickRandomElementsIndexes(questionObject.getNumberOfQuestions()))
      //viewController.questionsIndexes = RandomIndexPicker.pickRandomElementsIndexes(questionObject.getNumberOfQuestions())
      //viewController.questionsIndexes = [0,3]
      //print(questionObject.getNumberOfQuestions())

//      if let cell = sender as? UITableViewCell {
//        let indexPath = tableView.indexPathForCell(cell)
//        if let index = indexPath?.row {
//        }
//      }
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
//    guard let answersUn = answers else {
//      return 0
//    }
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell = UITableViewCell()
    
    var text = ""
    
    if indexPath.row == 0 {
      cell = tableView.dequeueReusableCellWithIdentifier("QuickTestCell")!
      text = "Quick test"
    } else {
      cell = tableView.dequeueReusableCellWithIdentifier("AllQuestionsCell")!
      text = "All questions"
    }
    
    cell.textLabel?.text = text
    cell.textLabel?.numberOfLines = 0
    
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //performSegueWithIdentifier("QuestionViewSegue", sender: nil)
  }

}