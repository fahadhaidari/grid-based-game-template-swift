//
//  Player.swift
//  GoGoGo
//
//  Created by Fahad Al Haidari on 3/16/19.
//  Copyright © 2019 Bitsake. All rights reserved.
//

import Foundation
import UIKit

struct Player {
  var row = 0
  var col = 0
  var view: UIView!
  
  init(_row: Int, _col: Int) {
    self.row = _row
    self.col = _col
  }
}
