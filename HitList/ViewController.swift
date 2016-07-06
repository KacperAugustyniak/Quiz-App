//
//  ViewController.swift
//  HitList
//
//  Created by Kacper Augustyniak on 23/04/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import UIKit
import CoreData
import GameplayKit

class QuestionViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

  @IBOutlet var answerIncorrectView: UIView!
  @IBOutlet var answerCorrectView: UIView!
  @IBOutlet weak var answerView: UIView!
  
  @IBOutlet weak var questionLabes: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  var people = [NSManagedObject]()
  var questionObject:QuestionDataIO!
  var mode:QuestionViewMode!
  var answers:NSOrderedSet?
  var answersArray:Array<AnyObject>?
  var selectionTable:Array<Bool>?
  var questionsIndexes:Array<Int>!
  var currentQuestionIndex:Int = 0
  var helpUrl:String?
  var explanation:String?
  
  @IBOutlet weak var onlineDocButton: UIButton!
  @IBOutlet weak var onlineDocButton2: UIButton!
  @IBOutlet weak var explanationButton: UIButton!
  @IBOutlet weak var redoQuestionButton: UIButton!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if questionObject == nil {
      questionObject = QuestionDataIO()
      print ("was nil")
    }
    //print(questionsIndexes)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
        onlineDocButton.hidden = true
        onlineDocButton2.hidden = true
        explanationButton.hidden = true
        redoQuestionButton.hidden = true
    mode.delegate = self
    showNextQuestion()

    answerView.hidden = true
    title = "\"The Test\""
    tableView.registerClass(UITableViewCell.self,
                            forCellReuseIdentifier: "Cell")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowExplanationSegue" {

      let viewController = segue.destinationViewController as! ExplanationViewController
      viewController.explanationText = self.explanation
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func displayQuestion(index:Int) {
    let questionReturns = questionObject.loadQuestion(index)
    self.questionLabes.text = questionReturns.question.text
    self.mode.shouldShowHelp(questionReturns.question)
    self.answers = questionReturns.answers
    self.answersArray = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(Array(self.answers!))
    
    self.selectionTable = [Bool](count:self.answers!.count, repeatedValue:false)
    
    tableView.reloadData()
  }
  
  @IBAction func addName(sender: AnyObject) {
    var allAnswersCorrect = true
    for (index,boolean) in selectionTable!.enumerate() {//checking
      let sss = self.answersArray?[index] as! Answer
      
      if boolean == sss.isCorrect{
        //print("oui")
      } else {
        allAnswersCorrect = false
        //wrong answers
      }
    }
    
    if allAnswersCorrect {
      // do correct
      mode.answerWasCorrect()
      clearAnswerView()
      presentViewInAnswerView(self.answerCorrectView )
    } else {
      //wrong
      mode.answerWasWrong()
      clearAnswerView()
      presentViewInAnswerView(self.answerIncorrectView )
    }
  }
  
  // MARK: UITableViewDataSource & delegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    guard let answersUn = answersArray else {
      return 0
    }
    return answersUn.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
    
    let text = self.answersArray?[indexPath.row].text
    
    cell!.textLabel!.text = text
    cell?.textLabel?.numberOfLines = 0
    
    return cell!
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.selectionTable![indexPath.row] = true
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    self.selectionTable![indexPath.row] = false
  }

  //MARK: questions something
  func showNextQuestion() {
    helpUrl = nil
    explanation = nil

    guard currentQuestionIndex < questionsIndexes.count else {
      mode.lastQuestionAnswered()
      //print("that was last question")
      return
    }
    
    self.displayQuestion(questionsIndexes[currentQuestionIndex])
    currentQuestionIndex += 1
  }
  
  func resetQuestionIndex() {
    currentQuestionIndex = 0
    showNextQuestion()
    clearAnswerView()
  }
  
  //MARK: answer views
  
  func clearAnswerView(){
    for view in self.view.subviews as [UIView] {
      view.userInteractionEnabled = true
    }
    self.answerView.hidden = true
    for view in self.answerView.subviews {
      view.removeFromSuperview()
    }
  }
  
  func presentViewInAnswerView(view:UIView ) {
    for view in self.view.subviews as [UIView] {
      view.userInteractionEnabled = false
    }
    self.answerView.userInteractionEnabled = true
    self.answerView.hidden = false
    self.answerView.addSubview(view)
  }
  
  func showStartOverPopup() {

  }
  
  @IBAction func nextQuestionButtonPressed(sender: AnyObject) {
    
    showNextQuestion()
    clearAnswerView()
  }

  @IBAction func explanationButtonPressed(sender: AnyObject) {
    //performSegueWithIdentifier("ShowExplanationSegue", sender: nil)
  }
  
  @IBAction func onlineDocPressed(sender: AnyObject) {
    UIApplication.sharedApplication().openURL(NSURL(string: helpUrl!)!)
  }
  
  @IBAction func redoQustionButtonPressed(sender: AnyObject) {
    clearAnswerView()
    for indexPath in tableView.indexPathsForVisibleRows! {
      self.selectionTable![indexPath.row] = false
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
  }
  
    //MARK: ignore this
  
//  func saveName(name: String) {
//    
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    
//    let managedContext = appDelegate.managedObjectContext
//    let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext:managedContext)
//    
//    let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
//    person.setValue(name, forKey: "name")
//    do {
//      try managedContext.save()
//      people.append(person)
//    } catch let error as NSError  {
//      print("Could not save \(error), \(error.userInfo)")
//    }
//  }
  
}

