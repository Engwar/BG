//
//GameField.swift
//  BG
//
//  Created by Igor Shelginskiy on 1/17/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class GameFieldViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollViewTable: UIScrollView!
    @IBOutlet weak var gameStackFields: UIStackView!
    @IBOutlet weak var gameTheme: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextField()
        }
    @IBOutlet var textAnswer: [UITextView]!
    
    private func updateTextField(){
        if gameTheme.text!.isEmpty {
            for index in textAnswer.indices {
                let field = textAnswer[index]
                field.backgroundColor = .gray
                field.isSelectable = false
                }
            } else {
            textAnswer[1].text = gameTheme.text!
            for index in textAnswer.indices {
                if index == 0 || index == 1 || index == 2 || index == 4 || index == 5 {
                    textAnswer[index].backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                } else {
                    textAnswer[index].isSelectable = false
                }
              }
            }
    }
    
    private func fieldSelected(){
        for index in textAnswer.indices {
            let field = textAnswer[index]
            if field.backgroundColor == #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), !field.text.isEmpty {
                
            }
        }
    }
    
}
