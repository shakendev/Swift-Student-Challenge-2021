import Foundation
import SpriteKit

extension GameScene {
    @objc(didBeginContact:)
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let objectNode = contact.bodyA.categoryBitMask == objectGroup ? contact.bodyA.node : contact.bodyB.node
        let rocketNode = contact.bodyA.categoryBitMask == rocketGroup ? contact.bodyA.node : contact.bodyB.node
        
        if Model.sharedInstance.score > Model.sharedInstance.highscore {
            Model.sharedInstance.highscore = Model.sharedInstance.score
        }
        UserDefaults.standard.set(Model.sharedInstance.highscore, forKey: "highScore")
        
        if contact.bodyA.categoryBitMask == objectGroup || contact.bodyB.categoryBitMask == objectGroup {
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            if shieldBool == false {
                animations.shakeAndFlashAnimation(view: self.view!)
                
                if Model.sharedInstance.sound == true {
                    run(electricGateDeadPreload)
                }
                
                Model.sharedInstance.totalscore = Model.sharedInstance.totalscore + Model.sharedInstance.score
                
                hero.physicsBody?.allowsRotation = false
                
                heroEmitterObject.removeAllChildren()
                coinObject.removeAllChildren()
                redCoinObject.removeAllChildren()
                groundObject.removeAllChildren()
                movingObject.removeAllChildren()
                rocketObject.removeAllChildren()
                shieldObject.removeAllChildren()
                shieldItemObject.removeAllChildren()
                
                stopGameObject()
                
                timerAddCoin.invalidate()
                timerAddRedCoin.invalidate()
                timerAddElectricGate.invalidate()
                timerAddRocket.invalidate()
                timerAddMine.invalidate()
                timerAddShieldItem.invalidate()
                
                heroDeathTexturesArray =  [SKTexture(imageNamed: "Images/scene.atlas/Dead0.png"), SKTexture(imageNamed: "Images/scene.atlas/Dead1.png"), SKTexture(imageNamed: "Images/scene.atlas/Dead2.png"), SKTexture(imageNamed: "Images/scene.atlas/Dead3.png"), SKTexture(imageNamed: "Images/scene.atlas/Dead4.png"), SKTexture(imageNamed: "Images/scene.atlas/Dead5.png"), SKTexture(imageNamed: "Images/scene.atlas/Dead6.png")]
                let heroDeathAnimation = SKAction.animate(with: heroDeathTexturesArray, timePerFrame: 0.2)
                hero.run(heroDeathAnimation)
                
                showHighscore()
                gameover = 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.scene?.isPaused = true
                    self.heroObject.removeAllChildren()
                    self.showHighscoreText()
                    
                    self.gameViewControllerBridge.reloadGameBtn.isHidden = false
                    self.gameViewControllerBridge.returnMainBtn.isHidden = false
                    
                    self.stageLabel.isHidden = true
                    
                    if Model.sharedInstance.score > Model.sharedInstance.highscore {
                        Model.sharedInstance.highscore = Model.sharedInstance.score
                    }
                    
                    self.highscoreLabel.isHidden = false
                    self.highscoreTextLabel.isHidden = false
                    self.highscoreLabel.text = "\(Model.sharedInstance.highscore)"
                })
                
                
                SKTAudio.sharedInstance().pauseBackgroundMusic()
            } else {
                objectNode?.removeFromParent()
                shieldObject.removeAllChildren()
                shieldBool = false
                if Model.sharedInstance.sound == true { run(shieldOffPreload) }
            }
        }
        
        if contact.bodyA.categoryBitMask == rocketGroup || contact.bodyB.categoryBitMask == rocketGroup {
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            if shieldBool == false {
                if  gameover == 0 {
                    animations.shakeAndFlashAnimation(view: self.view!)
                    
                    if Model.sharedInstance.sound == true { run(rocketExplosionPreload) }
                    
                    Model.sharedInstance.totalscore = Model.sharedInstance.totalscore + Model.sharedInstance.score
                    
                    rocketExplodeTexturesArray = [SKTexture(imageNamed: "Images/scene.atlas/RocketExplode0"),SKTexture(imageNamed: "Images/scene.atlas/RocketExplode1"),SKTexture(imageNamed: "Images/scene.atlas/RocketExplode2"),SKTexture(imageNamed: "Images/scene.atlas/RocketExplode3"),SKTexture(imageNamed: "Images/scene.atlas/RocketExplode4"),SKTexture(imageNamed: "Images/scene.atlas/RocketExplode5"),SKTexture(imageNamed: "Images/scene.atlas/RocketExplode6")]
                    
                    let rocketExplodeAnimation = SKAction.animate(with: rocketExplodeTexturesArray, timePerFrame: 0.1)
                    let rocketExp = SKAction.repeatForever(rocketExplodeAnimation)
                    rocketNode?.run(rocketExp)
                    
                    heroEmitterObject.removeAllChildren()
                    coinObject.removeAllChildren()
                    movingObject.removeAllChildren()
                    shieldItemObject.removeAllChildren()
                    
                    timerAddCoin.invalidate()
                    timerAddMine.invalidate()
                    timerAddElectricGate.invalidate()
                    timerAddRocket.invalidate()
                    timerAddRedCoin.invalidate()
                    timerAddShieldItem.invalidate()// redCoin
                    
                    heroDeathTexturesArray = [SKTexture(imageNamed: "Images/scene.atlas/Dead0"),SKTexture(imageNamed: "Images/scene.atlas/Dead1"),SKTexture(imageNamed: "Images/scene.atlas/Dead2"),SKTexture(imageNamed: "Images/scene.atlas/Dead3"),SKTexture(imageNamed: "Images/scene.atlas/Dead4"),SKTexture(imageNamed: "Images/scene.atlas/Dead5"),SKTexture(imageNamed: "Images/scene.atlas/Dead6")]
                    
                    let herodDeathAnimation = SKAction.animate(with: heroDeathTexturesArray, timePerFrame: 0.2)
                    hero.run(herodDeathAnimation)
                    
                    showHighscore()
                    gameover = 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.scene?.isPaused = true
                        self.heroObject.removeAllChildren()
                        self.showHighscoreText()
                        
                        self.gameViewControllerBridge.reloadGameBtn.isHidden = false
                        self.gameViewControllerBridge.returnMainBtn.isHidden = false
                        
                        self.stageLabel.isHidden = true
                        
                        if Model.sharedInstance.score > Model.sharedInstance.highscore {
                            Model.sharedInstance.highscore = Model.sharedInstance.score
                        }
                        
                        self.highscoreLabel.isHidden = false
                        self.highscoreTextLabel.isHidden = false
                        self.highscoreLabel.text = "\(Model.sharedInstance.highscore)"
                        
                        self.stopGameObject()
                    })
                }
                SKTAudio.sharedInstance().pauseBackgroundMusic()
                
            } else {
                rocketNode?.removeFromParent()
                shieldObject.removeAllChildren()
                shieldBool = false
                if Model.sharedInstance.sound == true { run(shieldOffPreload) }
            }
        }
        
        if contact.bodyA.categoryBitMask == shieldGroup || contact.bodyB.categoryBitMask == shieldGroup {
            levelUp()
            let shieldNode = contact.bodyA.categoryBitMask == shieldGroup ? contact.bodyA.node : contact.bodyB.node
            
            if shieldBool == false {
                if Model.sharedInstance.sound == true { run(pickCoinPreload) }
                shieldNode?.removeFromParent()
                addShield()
                shieldBool = true
            }
        }
        
        if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB.categoryBitMask == groundGroup {
            
            if gameover == 0 {
                heroEmitter2.isHidden = true
                
                heroRunTexturesArray =  [SKTexture(imageNamed: "Images/scene.atlas/Run0.png"), SKTexture(imageNamed: "Images/scene.atlas/Run1.png"), SKTexture(imageNamed: "Images/scene.atlas/Run2.png"), SKTexture(imageNamed: "Images/scene.atlas/Run3.png"), SKTexture(imageNamed: "Images/scene.atlas/Run4.png"), SKTexture(imageNamed: "Images/scene.atlas/Run5.png"), SKTexture(imageNamed: "Images/scene.atlas/Run6.png")]
                let heroRunAnimation = SKAction.animate(with: heroRunTexturesArray, timePerFrame: 0.1)
                let heroRun = SKAction.repeatForever(heroRunAnimation)
                hero.run(heroRun)
            }
        }
        
        if contact.bodyA.categoryBitMask == coinGroup || contact.bodyB.categoryBitMask == coinGroup {
            levelUp()
            let coinNode = contact.bodyA.categoryBitMask == coinGroup ? contact.bodyA.node : contact.bodyB.node
            
            if Model.sharedInstance.sound == true {
                run(pickCoinPreload)
            }
            
            switch stageLabel.text! {
            case "Stage 1":
                if gSceneDifficulty.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 1
                } else if gSceneDifficulty.rawValue == 1 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                } else if gSceneDifficulty.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
            case "Stage 2":
                if gSceneDifficulty.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                } else if gSceneDifficulty.rawValue == 1 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                } else if gSceneDifficulty.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
            case "Stage 3":
                if gSceneDifficulty.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                } else if gSceneDifficulty.rawValue == 1 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                } else if gSceneDifficulty.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
            default:break
            }
            
            scoreLabel.text = "\(Model.sharedInstance.score)"
            
            coinNode?.removeFromParent()
        }
        
        if contact.bodyA.categoryBitMask == redCoinGroup || contact.bodyB.categoryBitMask == redCoinGroup {
            levelUp()
            let redCoinNode = contact.bodyA.categoryBitMask == redCoinGroup ? contact.bodyA.node : contact.bodyB.node
            
            if Model.sharedInstance.sound == true {
                run(pickCoinPreload)
            }
            
            switch stageLabel.text! {
            case "Stage 1":
                if gSceneDifficulty.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                } else if gSceneDifficulty.rawValue == 1 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                } else if gSceneDifficulty.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
            case "Stage 2":
                if gSceneDifficulty.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                } else if gSceneDifficulty.rawValue == 1 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                } else if gSceneDifficulty.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
            case "Stage 3":
                if gSceneDifficulty.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                } else if gSceneDifficulty.rawValue == 1 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                } else if gSceneDifficulty.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
            default:break
            }
            
            scoreLabel.text = "\(Model.sharedInstance.score)"
            
            redCoinNode?.removeFromParent()
        }
        UserDefaults.standard.set(Model.sharedInstance.totalscore, forKey: "totalscore")
    }
}
