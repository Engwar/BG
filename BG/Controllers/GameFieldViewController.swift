//
//GameField.swift
//  BG
//
//  Created by Igor Shelginskiy on 1/17/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class GameFieldViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    var players = [Gamer]()
    var theme = String()
    
    @IBOutlet weak var scrollViewTable: UIScrollView!
    @IBOutlet weak var gameStackFields: UIStackView!
    @IBOutlet weak var carrentPlayer: UILabel!
    @IBOutlet var textAnswer: [UITextView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textAnswer.forEach{ $0.delegate = self } //делаем GameFieldViewController делегатом для каждого вью
        updateTextField()
        registerForKeyboardNotifications()
        }
    
    private func updateTextField(){
        textAnswer[1].text = theme
        if textAnswer[1].text!.isEmpty {         //если нет темы то ----
            for index in textAnswer.indices {
                let field = textAnswer[index]
                field.backgroundColor = .gray //поле затеняется серым
                field.isSelectable = false    // и его невозможно выбрать для редактирования
                }
            } else {
            for index in textAnswer.indices { // и для ближайших полей становится доступен выбор для редактирования и цвет
                if index == 0 || index == 1 || index == 2 || index == 4 || index == 5 {
                    textAnswer[index].backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                } else {
                    textAnswer[index].isSelectable = false
                }
              }
            }
        //для каждого поля устанавливается ограничение в 18 символов
//        textAnswer.forEach() { index in
//            if index.text.count >= 18 {
//                textViewShouldEndEditing(index)
//            }
//        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.endEditing(true)
        return true
    }
    
    private func fieldSelected(){
        for index in textAnswer.indices {
            let field = textAnswer[index]
            if field.backgroundColor == #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), !field.text.isEmpty {
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
    
}


