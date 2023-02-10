//
//  GameScene.swift
//  Bug Killer
//
//  Created by Dennis van Oosten on 10/02/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var score = 0 {
        didSet {
            scoreLabel.text = "score: \(score)"
        }
    }
    
    var scoreLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.createBug()
        }
        
        scoreLabel = SKLabelNode(text: "score: \(score)")
        scoreLabel.fontName = "Arial Black"
        scoreLabel.position.y = size.height / 2 - 150
        addChild(scoreLabel)
    }
    
    func createBug() {
        // Create Bug Sprite
        let bug = SKSpriteNode(imageNamed: "bug_1")
        bug.color = UIColor(named: "BugColor")!
        bug.colorBlendFactor = 1
        
        // Randomize position
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let posX = CGFloat.random(in: -screenWidth / 2 ..< screenWidth / 2)
        let posY = CGFloat.random(in: -screenHeight / 2 ..< screenHeight / 2)
        bug.position = CGPoint(x: posX, y: posY)
        
        // Randomize rotation
        let rotation = CGFloat.random(in: 0 ... 2 * .pi)
        bug.zRotation = rotation
        
        // Add Bug to the node tree
        addChild(bug)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if let touchedNode = nodes(at: touchLocation).first {
            touchedNode.removeFromParent()
            
            score += 10
        }
    }
    
}
