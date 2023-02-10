//
//  GameScene.swift
//  Bug Killer
//
//  Created by Dennis van Oosten on 10/02/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        createBug()
    }
    
    @objc func createBug() {
        let bug = SKSpriteNode(imageNamed: "bug_1")
        bug.color = UIColor(named: "BugColor")!
        bug.colorBlendFactor = 1
        addChild(bug)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if let touchedNode = nodes(at: touchLocation).first {
            touchedNode.removeFromParent()
        }
    }
    
}
