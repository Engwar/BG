//
//GameField.swift
//  BG
//
//  Created by Igor Shelginskiy on 1/17/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class GameFieldViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {

    var theme = String()
    var num = 0
    var turn = 0
    var decks = FieldsDeck()
    var players = [NewGameViewController.Gamer]()
    var currentPlayer = NewGameViewController.Gamer()
    
    @IBOutlet weak var scrollViewTable: UIScrollView!
    @IBOutlet weak var gameStackFields: UIStackView!
    @IBOutlet weak var curPlayer: UILabel!
    @IBOutlet var textAnswer: [UITextView]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textAnswer.forEach{ $0.delegate = self } //делаем GameFieldViewController делегатом для каждого вью
        textAnswer.forEach{ $0.isSelectable = false }
        textAnswer[1].text = theme
        registerForKeyboardNotifications()
        currentPlayer = players[num]
        updateTextField()
        textAnswer[1].backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        curPlayer.text = currentPlayer.name
        curPlayer.backgroundColor = currentPlayer.color
        }
    
    @IBAction func doneButton(_ sender: UIButton) {
        inspectText()
        updateView()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        for index in textAnswer.indices {
            if textAnswer[index].backgroundColor != #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.8865879774, green: 0.911493957, blue: 0.4669608474, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.4580307007, green: 0.9049122334, blue: 0.4451536536, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.9126871228, green: 0.5719250441, blue: 0.4921262264, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.5203970075, green: 0.4821320772, blue: 0.9096730351, alpha: 1) {
                textAnswer[index].text = String()
            }
        }
    }
    
    private func updateTextField() {
        let mass = decks.massField
        for index in textAnswer.indices {
            if !textAnswer[index].text.isEmpty &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.8865879774, green: 0.911493957, blue: 0.4669608474, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.4580307007, green: 0.9049122334, blue: 0.4451536536, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.9126871228, green: 0.5719250441, blue: 0.4921262264, alpha: 1) &&
                textAnswer[index].backgroundColor != #colorLiteral(red: 0.5203970075, green: 0.4821320772, blue: 0.9096730351, alpha: 1) {
                textAnswer[index].backgroundColor = currentPlayer.color
                textAnswer[index].isEditable = false
                textAnswer[index].isSelectable = false
                for i in mass.indices {
                    guard textAnswer[i].backgroundColor != #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) &&
                          textAnswer[i].backgroundColor != #colorLiteral(red: 0.8865879774, green: 0.911493957, blue: 0.4669608474, alpha: 1) &&
                          textAnswer[i].backgroundColor != #colorLiteral(red: 0.4580307007, green: 0.9049122334, blue: 0.4451536536, alpha: 1) &&
                          textAnswer[i].backgroundColor != #colorLiteral(red: 0.9126871228, green: 0.5719250441, blue: 0.4921262264, alpha: 1) &&
                          textAnswer[i].backgroundColor != #colorLiteral(red: 0.5203970075, green: 0.4821320772, blue: 0.9096730351, alpha: 1) else { continue }
                    if mass[index].first! == mass[i].first! {
                        if mass[index].last! - mass[i].last! == 1 ||
                            mass[index].last! - mass[i].last! == -1 {
                            textAnswer[i].backgroundColor = .white
                            textAnswer[i].isEditable = true
                        }
                    }
                    if mass[index].first! < 2 {
                    if mass[index].first! - mass[i].first! == 1 ||
                        mass[index].first! - mass[i].first! == -1 {
                        if mass[index].last! - mass[i].last! == 0 ||
                            mass[index].last! - mass[i].last! == -1 {
                            textAnswer[i].backgroundColor = .white
                            textAnswer[i].isEditable = true
                            }
                        }
                    } else if mass[index].first! == 2 {
                        if mass[index].first! - mass[i].first! == 1 || mass[index].first! - mass[i].first! == -1 {
                            if mass[index].last! - mass[i].last! == 0 || mass[index].last! - mass[i].last! == 1 {
                                textAnswer[i].backgroundColor = .white
                                textAnswer[i].isEditable = true
                            }
                        }
                    } else if mass[index].first! > 2 {
                        if mass[index].first! - mass[i].first! == 1 {
                            if mass[index].last! - mass[i].last! == 0 || mass[index].last! - mass[i].last! == -1 {
                                textAnswer[i].backgroundColor = .white
                                textAnswer[i].isEditable = true
                            }
                        } else if mass[index].first! - mass[i].first! == -1 {
                            if mass[index].last! - mass[i].last! == 0 || mass[index].last! - mass[i].last! == 1 {
                                textAnswer[i].backgroundColor = .white
                                textAnswer[i].isEditable = true
                            }
                        }
                    }
                }
            }
        }
    }
    

    //делаем этот метод чтобы клавиатура не закрывала поля, регистрируемся в центре сообщений, добавляя наблюдатель
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self, //экземпляр, который будет наблюдатся(то есть тот экземпляр в котором расположены методы которые будут вызываться), в данном случае мы сами
            selector: #selector(keyboardWasShown(_:)), //передача управления необходимой функции
            name: UIResponder.keyboardDidShowNotification, //здесь мы пишем событие на которое подписываемся
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    
    //прокрутка tableView когда клавиатура всплыла, в данном случае нам необходимо знать размеры клавиатуры
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
            let keyboardFrameValue = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardSize = keyboardFrameValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 40, right: 0.0)
        scrollViewTable.contentInset = contentInsets //устанавливаем отступы
        scrollViewTable.scrollIndicatorInsets = contentInsets
    }
    
    //прокрутка когда клавиатура убралась
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollViewTable.contentInset = contentInsets
        scrollViewTable.scrollIndicatorInsets = contentInsets
    }
    
    //убираем клавиатуру когда нажимаем на каком нибудь месте
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //уменьшаем количество символов в текствью до 18
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count < 15
    }
    
    //функция проверяет чтобы только одно доступное поле было заполнено текстом
    private func inspectText() {
        var count = 0
        for i in textAnswer.indices {
            guard textAnswer[i].backgroundColor == UIColor.white && !textAnswer[i].text.isEmpty else {continue}
            count += 1
            turn += 1
            textAnswer[i].text = "\(turn)\n" + textAnswer[i].text
        }
        if count > 1 {
            for i in textAnswer.indices {
                guard textAnswer[i].backgroundColor == UIColor.white && !textAnswer[i].text.isEmpty else {continue}
                textAnswer[i].text = String()
                turn -= 1
            }
        }
        guard count == 1 else {return}
        updateTextField()
        nextPlayer()
    }
    
    //переключаем очередность игроков
    func nextPlayer() {
        num += 1
        if num > players.count - 1 {
            num = 0
            currentPlayer = players[num]
        } else {
            currentPlayer = players[num]
        }
    }
    
    //обновляем имя текущего игрока и вносим его цвет
    func updateView() {
        curPlayer.text = currentPlayer.name
        curPlayer.backgroundColor = currentPlayer.color
    }
}


