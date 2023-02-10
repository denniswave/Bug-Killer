//
//  GameScene.swift
//  Bug Killer
//
//  Created by Dennis van Oosten on 10/02/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var score = 0 {
        didSet {
            scoreLabel.text = "score: \(score)"
        }
    }
    
    private var scoreLabel: SKLabelNode!
    
    private var bugAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Bug")
    }
    
    private var bugTextures: [SKTexture] {
        return [
            bugAtlas.textureNamed("bug_1"),
            bugAtlas.textureNamed("bug_2"),
            bugAtlas.textureNamed("bug_3"),
            bugAtlas.textureNamed("bug_4"),
            bugAtlas.textureNamed("bug_3"),
            bugAtlas.textureNamed("bug_2")
        ]
    }
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.createBug()
        }
        
        scoreLabel = SKLabelNode(text: "score: \(score)")
        scoreLabel.fontName = "Arial Black"
        scoreLabel.position.y = size.height / 2 - 150
        addChild(scoreLabel)
    }
    
    private func createBug() {
        // Create Bug Sprite
        let bug = SKSpriteNode(imageNamed: "bug_1")
        bug.color = UIColor(named: "BugColor")!
        bug.colorBlendFactor = 1
        bug.setScale(0)
        
        // Animate in
        let growAction = SKAction.scale(to: 1.2, duration: 0.1)
        let shrinkAction = SKAction.scale(to: 1, duration: 0.1)
        let appearAction = SKAction.sequence([growAction, shrinkAction])
        appearAction.timingMode = .easeInEaseOut
        bug.run(appearAction)
        
        // Randomize position
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let posX = CGFloat.random(in: -screenWidth / 2 ..< screenWidth / 2)
        let posY = CGFloat.random(in: -screenHeight / 2 ..< screenHeight / 2)
        bug.position = CGPoint(x: posX, y: posY)
        
        // Randomize rotation
        let rotation = CGFloat.random(in: 0 ... 2 * .pi)
        bug.zRotation = rotation
        
        // Animate textures
        let bugAnimation = SKAction.animate(with: bugTextures, timePerFrame: 1 / 30)
        bug.run(SKAction.repeatForever(bugAnimation))
        
        // Add Bug to the node tree
        addChild(bug)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if let touchedNode = nodes(at: touchLocation).first {
            let growAction = SKAction.scale(to: 1.2, duration: 0.1)
            let shrinkAction = SKAction.scale(to: 0, duration: 0.1)
            let removeAction = SKAction.removeFromParent()
            let killAction = SKAction.sequence([growAction, shrinkAction, removeAction])
            touchedNode.run(killAction)
            
            score += 10
        }
    }
    
}
