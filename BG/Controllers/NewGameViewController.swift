//
//  NewGameViewController.swift
//  BG
//
//  Created by Igor Shelginskiy on 5/1/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {
    
    @IBOutlet weak var themeText: UITextField!
    @IBOutlet weak var amountGamers: UILabel!
    @IBOutlet weak var amountStepGamers: UIStepper!
    @IBOutlet weak var startGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountStepGamers.value = startValue
        amountStepGamers.minimumValue = minValue
        amountStepGamers.maximumValue = maxValue
    }
    
    
    @IBAction func amountGamerStepper(_ sender: UIStepper) {
        amountGamers.text = String(Int(amountStepGamers.value))
        
    
// делаем кнопку "Играть" активной если количество игроков удовлетворительное (1-3)
//        if Int(amountStepGamers.value) > 0 && Int(amountStepGamers.value) < 4 {
//            startGame.isEnabled = true
//            startGame.alpha = 1.0
//        } else {
//            startGame.isEnabled = false
//            startGame.alpha = 0.5
//        }
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        
    }
    
}

//------Constants-------//
let minValue = 1.0
let maxValue = 3.0
let startValue = 1.0
