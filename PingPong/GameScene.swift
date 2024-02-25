//
//  GameScene.swift
//  PingPong
//
//  Created by David Grau Beltrán  on 24/02/24.
//

import SpriteKit
import GameplayKit

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var playerPaddle = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
       
        
        let bshapes = BShapes()
        bshapes.position = CGPoint(x: 0, y: 0)
        addChild(bshapes)
        
        topLbl = self.childNode(withName: "topLbl") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLbl") as! SKLabelNode

        self.physicsWorld.contactDelegate = self
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        //print(self.view?.bounds.height)
        
        enemyPaddle = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        enemyPaddle.position.y = (self.frame.height / 2) - 50
        
        playerPaddle = self.childNode(withName: "playerPaddle") as! SKSpriteNode
        playerPaddle.position.y = (-self.frame.height / 2) + 50
        
        
        
       
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
    }
    
    func checkGameEnd() {
        if score[1] == 5 || score[0] == 5 {
            let gameOverLabel = SKLabelNode(text: "Game Over")
            gameOverLabel.fontName = "Helvetica-Bold" // Change the font name here
            gameOverLabel.fontSize = 50
            gameOverLabel.position = CGPoint(x: 0, y: 0)
            addChild(gameOverLabel)
            
            // Pause the game
            self.isPaused = true
            
            
            // Restart the game after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isPaused = false
                gameOverLabel.removeFromParent()
                self.startGame()
                self.score[1] = 0
                self.score[0] = 0
                self.resetGame()
                
            }
        }
    }

    func resetGame() {
           ball.position = CGPoint(x: 0, y: 0)
           ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
           ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
           
       }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == playerPaddle{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if playerWhoWon == enemyPaddle{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
            
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self) //move acourding touching finger
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemyPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
            }
            else {
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
       
       
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self) //move acourding touching finger
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemyPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
            }
            else {
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            
           
        }

        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        switch currentGameType {
        case.easy:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
            
        case.medium:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
            
        case.hard:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            break
            
        case.player2:
            
            break
            
        }
        
        
        
        if ball.position.y <= playerPaddle.position.y - 30 {
            addScore(playerWhoWon: enemyPaddle)
        }
        else if ball.position.y >= enemyPaddle.position.y + 30 {
            addScore(playerWhoWon: playerPaddle)
            
        }
        
        checkGameEnd()
    }
}
