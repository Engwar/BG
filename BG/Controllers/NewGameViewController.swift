//
//  NewGameViewController.swift
//  BG
//
//  Created by Igor Shelginskiy on 5/1/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {

    var theme = String()
    var playerFields = [UITextField]()
    var numGamers = [Gamer]()
    
    @IBOutlet weak var themeText: UITextField!
    @IBOutlet weak var amountGamers: UILabel!
    @IBOutlet weak var amountStepGamers: UIStepper!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var firstPlayer: UITextField!
    @IBOutlet weak var secondPlayer: UITextField!
    @IBOutlet weak var thirdPlayer: UITextField!
    @IBOutlet weak var fourthPlayer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeText.text = theme
        themeText.delegate = self  //Делаем наш View Controller делегатом протокола UITextFieldDelegate, чтобы убирать клавиатуру
        playerFields = [firstPlayer, secondPlayer, thirdPlayer, fourthPlayer]
        playerFields.forEach({$0.delegate = self; $0.isEnabled = false; $0.alpha = 0.5})
        updateAmountPlayers()
        tryStartGame()
        addGamers()
    }

    //делаем переход по кнопке Играть и назначаем тему в первое поле
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "gameFieldSegue" {
            let vc = segue.destination as! GameFieldViewController
            vc.theme = self.theme
            vc.players = numGamers
        }
    }
    
    //убираем клаву когда нажимаем за пределами textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        tryStartGame()
        //делаем всплывающее окно с подсказкой
        if themeText.text!.isEmpty {
            let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpVCid") as! PopUpViewController
            self.addChild(popUpVC)
            popUpVC.view.frame = self.view.frame
            self.view.addSubview(popUpVC.view)
            popUpVC.didMove(toParent: self)
        }
    }
    
    @IBAction func amountGamerStepper(_ sender: UIStepper) {
        updateAmountPlayers()
        tryStartGame()
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        self.theme = themeText.text!
        addGamers()
        performSegue(withIdentifier: "gameFieldSegue", sender: self)
        print(numGamers)
    }
    
    // MARK: --- Methods
    
    //убираем клаву когда нажимаем return
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        themeText.resignFirstResponder()
        playerFields.forEach({$0.resignFirstResponder()})
        tryStartGame()
        return true
    }
    
    //обновляем количество игроков и активируем/деактивируем поля имен игроков
    private func updateAmountPlayers() {
        let num = Int(amountStepGamers.value)
        amountGamers.text = String(num)
        switch num {
          case 2: playerFieldEnabled(for: secondPlayer)
                  playerFieldDisabled(for: thirdPlayer)
                  playerFieldDisabled(for: fourthPlayer)
            
          case 3: playerFieldEnabled(for: thirdPlayer)
                  playerFieldDisabled(for: fourthPlayer)
            
          case 4: playerFieldEnabled(for: fourthPlayer)
            
        default:  playerFieldEnabled(for: firstPlayer)
                  playerFieldDisabled(for: fourthPlayer)
                  playerFieldDisabled(for: thirdPlayer)
                  playerFieldDisabled(for: secondPlayer)
        }
    }
    
    //кнопка активна когда введен текст темы
    private func tryStartGame() {
        if themeText.text!.isEmpty {
            startGame.isEnabled = false
            startGame.alpha = 0.5
        } else {
            startGame.isEnabled = true
            startGame.alpha = 1.0
        }
        for player in playerFields {
            if player.isEnabled && player.text!.isEmpty {
                startGame.isEnabled = false
                startGame.alpha = 0.5
            }
        }
    }
    
    struct Gamer {
        var name = String()
        var score = 0
        var color = UIColor()
    }
    
}

extension NewGameViewController {
    
    private func playerFieldEnabled (for selected: UITextField) {
        selected.isEnabled = true
        selected.alpha = 1.0
        selected.placeholder = "Введите имя игрока"
    }
    
    private func playerFieldDisabled (for selected: UITextField) {
        selected.isEnabled = false
        selected.alpha = 0.5
        selected.text = ""
        selected.placeholder = ""
    }
    
    private func addGamers() {
        switch Int(amountStepGamers.value) {
            
        case 2: numGamers = [Gamer(name: "\(firstPlayer.text!)", score: 0, color: #colorLiteral(red: 0.8865879774, green: 0.911493957, blue: 0.4669608474, alpha: 1)),
                             Gamer(name: "\(secondPlayer.text!)", score: 0, color: #colorLiteral(red: 0.4580307007, green: 0.9049122334, blue: 0.4451536536, alpha: 1))]
            
        case 3: numGamers = [Gamer(name: "\(firstPlayer.text!)", score: 0, color: #colorLiteral(red: 0.8865879774, green: 0.911493957, blue: 0.4669608474, alpha: 1)),
                             Gamer(name: "\(secondPlayer.text!)", score: 0, color: #colorLiteral(red: 0.4580307007, green: 0.9049122334, blue: 0.4451536536, alpha: 1)),
                             Gamer(name: "\(thirdPlayer.text!)", score: 0, color: #colorLiteral(red: 0.9126871228, green: 0.5719250441, blue: 0.4921262264, alpha: 1))]
            
        case 4: numGamers = [Gamer(name: "\(firstPlayer.text!)", score: 0, color: #colorLiteral(red: 0.8865879774, green: 0.911493957, blue: 0.4669608474, alpha: 1)),
                             Gamer(name: "\(secondPlayer.text!)", score: 0, color: #colorLiteral(red: 0.4580307007, green: 0.9049122334, blue: 0.4451536536, alpha: 1)),
                             Gamer(name: "\(thirdPlayer.text!)", score: 0, color: #colorLiteral(red: 0.9126871228, green: 0.5719250441, blue: 0.4921262264, alpha: 1)),
                             Gamer(name: "\(fourthPlayer.text!)", score: 0, color: #colorLiteral(red: 0.5203970075, green: 0.4821320772, blue: 0.9096730351, alpha: 1))]
            
        default: numGamers = [Gamer(name: "\(firstPlayer.text!)", score: 0, color: #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1))]
        }
        numGamers = numGamers.shuffled()
    }
}
