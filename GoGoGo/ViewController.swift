//
//  ViewController.swift
//  GoGoGo
//
//  Created by Fahad Al Haidari on 3/13/19.
//  Copyright © 2019 Bitsake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var cellSize = 0
  var matrix: [[Int]] = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ]
  var marginHorz = 0
  var marginVert = 0
  var container: UIView!
  var timer: Timer!
  var player: Player!
  var label: UILabel!
  var obstacles: [Obstacle] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    addContainer()
    setup()
    Grid.draw(_matrix: matrix, _container: container, _cellSize: cellSize)
    addPlayer()
    addObstacles()
    addDebuggerLabel()
    timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
  }
  
  func addContainer() {
    let size = self.view.frame.width * 0.9;
    container = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size));
    container.center = self.view.center
    self.view.addSubview(container);
  }
  
  func setup() {
    marginHorz = Int(container.frame.origin.x)
    marginVert = Int(container.frame.origin.y)
    cellSize = Int(container.frame.width / CGFloat(matrix[0].count));
  }
  
  func addPlayer() {
    player = Player(_row: matrix[0].count - 2, _col: Int(matrix[0].count / 2))
    player.view = UIView(frame: CGRect(x: player.col * cellSize, y: player.row * cellSize, width: cellSize, height: cellSize));
    player.view.layer.cornerRadius = 5
    player.view.layer.borderWidth = 1
    player.view.backgroundColor = UIColor.orange;
    container.addSubview(player.view);
  }
  
  func addObstacles() {
    for i in 0...5 {
      let obstacle = Obstacle(_row: 1, _col: i)
      obstacle.view =  UIView(frame: CGRect(x: obstacle.col * cellSize, y: obstacle.row * cellSize, width: cellSize, height: cellSize))
      obstacle.view.layer.cornerRadius = 5
      obstacle.view.layer.borderWidth = 1
      obstacle.view.backgroundColor = UIColor.red
      container.addSubview(obstacle.view)
      obstacles.append(obstacle)
    }
  }
  
  func addDebuggerLabel() {
    label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    label.center = CGPoint(x: 80, y: 80)
    label.textAlignment = .center
    label.textColor = UIColor.blue
    label.text = "Row: " + String(player.row) + " Col: " + String(player.col);
    self.view.addSubview(label)
  }

  @objc func tick() {
    // update obstacles
    for i in 0...obstacles.count - 1 {
      let obstacle = obstacles[i]
      
      matrix[obstacle.row][obstacle.col] = 0
      
      obstacle.row += 1
      
      if (obstacle.row > matrix.count - 1) {
        obstacle.row = 0
        obstacle.col += 1
      }
      
      if (obstacle.col > matrix[0].count - 1) {
        obstacle.col = 0
      }
    
      moveObstacle(obstacle: obstacle, row: obstacle.row, col: obstacle.col)
    }
  }
  
  func updatePlayer(x: CGFloat) {
    if (x < self.view.frame.width / 2) {
      if (player.col - 1 >= 0) {
        player.col -= 1
      }
    } else {
      if (player.col < matrix[0].count - 1) {
        player.col += 1
      }
    }
  }
  
  func movePlayer(row: Int, col: Int) {
    matrix[row][col] = 1 // update matrix based on player's new row/col
    player.view.frame.origin.x = CGFloat(col * cellSize)
  }
  
  func moveObstacle(obstacle: Obstacle, row: Int, col: Int) {
    matrix[row][col] = 1 // update matrix based on obstacle's new row/col
    obstacle.view.frame.origin.x = CGFloat(col * cellSize)
    obstacle.view.frame.origin.y = CGFloat(row * cellSize)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    matrix[player.row][player.col] = 0 // reset previous cell value
    updatePlayer(x: touches.first!.location(in: self.view).x)
    movePlayer(row: player.row, col: player.col)
    label.text = "Row: " + String(player.row) + " Col: " + String(player.col);
  }
}
