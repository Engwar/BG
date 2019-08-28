//
//  PopUpViewController.swift
//  BG
//
//  Created by Igor Shelginskiy on 8/21/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var messageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.layer.cornerRadius = 24 //скругляем углы
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75) // затеняем задний фон
        moveIn()
    }
    

    @IBAction func closePopUp(_ sender: UIButton) {
        //self.view.removeFromSuperview() // удаляем сообщение при нажатии
        moveOut()
    }
    
    //анимируем появление и скрытие окна
    func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    func moveOut() {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
}
