//
//  ExplanationViewController.swift
//  HitList
//
//  Created by Kacper Augustyniak on 27/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

import Foundation
import UIKit

class ExplanationViewController: UIViewController {
  var explanationText:String!
  
  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let text = explanationText else {
      return
    }
    textView.text = text
    
  }
}
