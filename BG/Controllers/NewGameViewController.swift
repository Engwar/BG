//
//  NewGameViewController.swift
//  BG
//
//  Created by Igor Shelginskiy on 5/1/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {

    var  theme = String()
    
    @IBOutlet weak var themeText: UITextField!
    @IBOutlet weak var amountGamers: UILabel!
    @IBOutlet weak var amountStepGamers: UIStepper!
    @IBOutlet weak var startGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeText.text = theme
        themeText.delegate = self //Делаем наш View Controller делегатом протокола UITextFieldDelegate, чтобы убирать клавиатуру
        amountStepGamers.value = startValue
        amountStepGamers.minimumValue = minValue
        amountStepGamers.maximumValue = maxValue
        updateAmountPlayers()
        tryStartGame()
        
    }
    
    
    @IBAction func amountGamerStepper(_ sender: UIStepper) {
        updateAmountPlayers()
        //performSegue(withIdentifier: "playerSegue", sender: self) проблема с сегвеем
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        self.theme = themeText.text!
        performSegue(withIdentifier: "gameFieldSegue", sender: self)
    }
    
    //делаем переход по кнопке Играть и назначаем тему в первое поле
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameFieldSegue" {
            let vc = segue.destination as! GameFieldViewController
            vc.theme = self.theme
        } else if segue.identifier == "playerSegue" {
            let vc = segue.destination as! PlayersTableViewController
            vc.numOfPlayers = Int(amountGamers.text!)!
        }
    }
    
    //убираем клаву когда нажимаем return
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        themeText.resignFirstResponder()
        tryStartGame()
        return true
    }
    
    //убираем клаву когда нажимаем за пределами textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        tryStartGame()
        //делаем всплывающее окно с подсказкой
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpVCid") as! PopUpViewController
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: self)
    }
// делаем кнопку "Играть" активной если количество игроков удовлетворительное (1-3)
//        if Int(amountStepGamers.value) > 0 && Int(amountStepGamers.value) < 4 {
//            startGame.isEnabled = true
//            startGame.alpha = 1.0
//        } else {
//            startGame.isEnabled = false
//            startGame.alpha = 0.5
//        }

    private func updateAmountPlayers() {
        amountGamers.text = String(Int(amountStepGamers.value))
    }
    
    private func tryStartGame() {
        if themeText.text!.isEmpty {
            startGame.isEnabled = false
            startGame.alpha = 0.5
        } else {
            startGame.isEnabled = true
            startGame.alpha = 1.0
        }
    }
    
}

//------Constants-------//
let minValue = 1.0
let maxValue = 3.0
let startValue = 1.0
