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
            bugAtlas.textureNamed("bug_5"),
            bugAtlas.textureNamed("bug_6"),
            bugAtlas.textureNamed("bug_7"),
            bugAtlas.textureNamed("bug_6"),
            bugAtlas.textureNamed("bug_5"),
            bugAtlas.textureNamed("bug_4"),
            bugAtlas.textureNamed("bug_3"),
            bugAtlas.textureNamed("bug_2")
        ]
    }
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { _ in
            self.createBug()
        }
        
        scoreLabel = SKLabelNode(text: "score: \(score)")
        scoreLabel.fontName = "Helvetica-Bold"
        scoreLabel.fontSize = 48
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
        let sceneWidth = size.width - 50
        let sceneHeight = size.height - 50
        let posX = CGFloat.random(in: -sceneWidth / 2 ..< sceneWidth / 2)
        let posY = CGFloat.random(in: -sceneHeight / 2 ..< sceneHeight / 2 - 200)
        bug.position = CGPoint(x: posX, y: posY)
        
        // Randomize rotation
        let rotation = CGFloat.random(in: 0 ... 2 * .pi)
        bug.zRotation = rotation
        
        // Animate textures
        let bugAnimation = SKAction.animate(with: bugTextures, timePerFrame: 1 / 60)
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
