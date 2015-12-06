//
//  Board.swift
//  Monst-ios
//
//  Created by Tatsuya Oba on 2015/12/06.
//  Copyright © 2015年 Tatsuya Oba. All rights reserved.
//

import Foundation
import UIKit

class Board {
    var button: UIButton?
    let name: String
    let url: String

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    func setButton(button: UIButton) {
        self.button = button
    }
    
    func getButton() -> UIButton? {
        return self.button
    }

}