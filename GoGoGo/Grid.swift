//
//  Grid.swift
//  GoGoGo
//
//  Created by Fahad Al Haidari on 3/16/19.
//  Copyright © 2019 Bitsake. All rights reserved.
//

import Foundation
import UIKit

class Grid {
  static func draw(_matrix: [[Int]], _container: UIView, _cellSize: Int) {
    for i in 0..._matrix.count - 1 {
      for j in 0..._matrix[i].count - 1 {
        let v = UIView(frame: CGRect(x: j * _cellSize, y: i * _cellSize, width: _cellSize, height: _cellSize));
        v.layer.cornerRadius = 5
        v.layer.borderWidth = 1
        _container.addSubview(v)
      }
    }
  }
}
