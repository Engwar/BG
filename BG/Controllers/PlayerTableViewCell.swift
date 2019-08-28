//
//  PlayerTableViewCell.swift
//  BG
//
//  Created by Igor Shelginskiy on 8/21/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var playerName: UITextField! 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerName.delegate = self
    }
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        playerName.resignFirstResponder()
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
