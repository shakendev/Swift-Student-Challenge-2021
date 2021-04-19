import UIKit
import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Animations
    var animations = AnimationClass()
    
    //Variables
    var gameViewControllerBridge: GameViewController!
    var moveElectricGateY = SKAction()
    var shieldBool = false
    var gameover = 0
    var rangeRocket :CGFloat = 0.50
    var gSceneDifficulty: DifficultyChoosing!
    var gSceneBg: BgChoosing!
    
    //Texture
    var bgTexture: SKTexture!
    var flyHeroTex: SKTexture!
    var runHeroTex: SKTexture!
    var coinTexture: SKTexture!
    var redCoinTexture: SKTexture!
    var coinHeroTex: SKTexture!
    var redCoinHeroTex: SKTexture!
    var electricGateTex: SKTexture!
    var deadHeroTex: SKTexture!
    var shieldTexture: SKTexture!
    var shieldItemTexture: SKTexture!
    var mineTexture1: SKTexture!
    var mineTexture2: SKTexture!
    var rocketTex : SKTexture!
    var rocketExplodeTex : SKTexture!
    
    //Emitters Node
    var heroEmitter2 = SKEmitterNode()
    
    //Label Nodes
    var tabToPlayLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var highscoreTextLabel = SKLabelNode()
    var stageLabel = SKLabelNode()
    
    //Sprite Nodes
    var bg = SKSpriteNode()
    var ground = SKSpriteNode()
    var sky = SKSpriteNode()
    var hero = SKSpriteNode()
    var coin = SKSpriteNode()
    var redCoin = SKSpriteNode()
    var electricGate = SKSpriteNode()
    var shield = SKSpriteNode()
    var shieldItem = SKSpriteNode()
    var mine = SKSpriteNode()
    var rocket = SKSpriteNode()
    
    
    //Sprite Objects
    var bgObject = SKNode()
    var groundObject = SKNode()
    var movingObject = SKNode()
    var heroObject = SKNode()
    var heroEmitterObject = SKNode()
    var coinObject = SKNode()
    var redCoinObject = SKNode()
    var shieldObject = SKNode()
    var shieldItemObject = SKNode()
    var labelObject = SKNode()
    var rocketObject = SKNode()
    
    //Bit masks
    var heroGroup: UInt32 = 0x1 << 1
    var groundGroup: UInt32 = 0x1 << 2
    var coinGroup: UInt32 = 0x1 << 3
    var redCoinGroup: UInt32 = 0x1 << 4
    var objectGroup: UInt32 = 0x1 << 5
    var shieldGroup: UInt32 = 0x1 << 6
    var rocketGroup : UInt32 = 0x1 << 7
    
    //Textures Array for animateWithTextures
    var heroFlyTexturesArray = [SKTexture]()
    var heroRunTexturesArray = [SKTexture]()
    var coinTexturesArray = [SKTexture]()
    var electricGateTexturesArray = [SKTexture]()
    var heroDeathTexturesArray = [SKTexture]()
    var rocketTexturesArray = [SKTexture]()
    var rocketExplodeTexturesArray = [SKTexture]()
    
    //Timers
    var timerAddCoin = Timer()
    var timerAddRedCoin = Timer()
    var timerAddElectricGate = Timer()
    var timerAddShieldItem = Timer()
    var timerAddMine = Timer()
    var timerAddRocket = Timer()
    
    //Sounds
    var pickCoinPreload = SKAction()
    var electricGateCreatePreload = SKAction()
    var electricGateDeadPreload = SKAction()
    var shieldOnPreload = SKAction()
    var shieldOffPreload = SKAction()
    var rocketCreatePreload = SKAction()
    var rocketExplosionPreload = SKAction()
    
    public override func didMove(to view: SKView) {
        //Background texture
//        bgTexture = SKTexture(imageNamed: "bg01.png")
        bgTexture = SKTexture(imageNamed: "Images/Backgrounds/Levels/Level #1/Level Background #1.png")
        
        //Hero texture
        flyHeroTex = SKTexture(imageNamed: "Images/scene.atlas/Fly0.png")
        runHeroTex = SKTexture(imageNamed: "Images/scene.atlas/Run0.png")
        
        //Coin texture
        coinTexture = SKTexture(imageNamed: "Images/scene.atlas/coin.jpg")
        redCoinTexture = SKTexture(imageNamed: "Images/scene.atlas/coin.jpg")
        coinHeroTex = SKTexture(imageNamed: "Images/scene.atlas/Coin0.png")
        redCoinHeroTex = SKTexture(imageNamed: "Images/scene.atlas/Coin0.png")
        
        //ElectricGate texture
        electricGateTex = SKTexture(imageNamed: "Images/scene.atlas/ElectricGate01.png")
        
        //Shields and shield item texture
        shieldTexture = SKTexture(imageNamed: "Images/scene.atlas/shield.png")
        shieldItemTexture = SKTexture(imageNamed: "Images/scene.atlas/shieldItem.png")
        
        //Mines texture
        mineTexture1 = SKTexture(imageNamed: "Images/scene.atlas/mine1.png")
        mineTexture2 = SKTexture(imageNamed: "Images/scene.atlas/mine2.png")
        
        // Rocket Textures
        rocketTex = SKTexture(imageNamed: "Images/scene.atlas/Rocket0.png")
        rocketExplodeTex = SKTexture(imageNamed: "Images/scene.atlas/RocketExplode0.png")
        
        //Emitters
        heroEmitter2 = SKEmitterNode(fileNamed: "VFX/engine.sks")!
        
        self.physicsWorld.contactDelegate = self
        
        createObjects()
        
        if UserDefaults.standard.object(forKey: "highScore") != nil {
            Model.sharedInstance.highscore = UserDefaults.standard.object(forKey: "highScore") as! Int
            highscoreLabel.text = "\(Model.sharedInstance.highscore)"
        }
        
        if UserDefaults.standard.object(forKey: "totalscore") != nil {
            Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalscore") as! Int
        }
        
        if gameover == 0 {
            createGame()
        }
        
        pickCoinPreload = SKAction.playSoundFileNamed("SFX/Sounds/Coin/pickCoin.mp3", waitForCompletion: false)
        electricGateCreatePreload = SKAction.playSoundFileNamed("SFX/Sounds/Electric Gate/electricCreate.wav", waitForCompletion: false)
        electricGateDeadPreload = SKAction.playSoundFileNamed("SFX/Sounds/Electric Gate/electricDead.mp3", waitForCompletion: false)
        shieldOnPreload = SKAction.playSoundFileNamed("SFX/Sounds/Shield/shieldOn.mp3", waitForCompletion: false)
        shieldOffPreload = SKAction.playSoundFileNamed("SFX/Sounds/Shield/shieldOff.mp3", waitForCompletion: false)
        rocketExplosionPreload = SKAction.playSoundFileNamed("SFX/Sounds/Rocket/rocketExplosion.wav", waitForCompletion: false)
        rocketCreatePreload = SKAction.playSoundFileNamed("SFX/Sounds/Rocket/rocketCreate.wav", waitForCompletion: false)
    }
    
    func createObjects() {
        self.addChild(bgObject)
        self.addChild(groundObject)
        self.addChild(movingObject)
        self.addChild(heroObject)
        self.addChild(heroEmitterObject)
        self.addChild(coinObject)
        self.addChild(redCoinObject)
        self.addChild(shieldObject)
        self.addChild(shieldItemObject)
        self.addChild(labelObject)
        self.addChild(rocketObject)
    }
    
    func createGame() {
        createBg()
        createGround()
        createSky()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.createHero()
            self.createHeroEmitter()
            self.timerFunc()
            self.addElectricGate()
        }
        
        showTapToPlay()
        showScore()
        showStage()
        highscoreTextLabel.isHidden = true
        
        gameViewControllerBridge.reloadGameBtn.isHidden = true
        gameViewControllerBridge.returnMainBtn.isHidden = true
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
    }
    
    func createBg() {
        var correctHeight: CGFloat = 0
        switch gSceneBg.rawValue {
        case 0:
            bgTexture = SKTexture(imageNamed: "Images/Backgrounds/Levels/Level #1/Level Background #1.png")
            correctHeight = 2.0
        case 1:
            bgTexture = SKTexture(imageNamed: "Images/Backgrounds/Levels/Level #2/Level Background #2.png")
            correctHeight = 1.8
        default:
            break
        }
        
        let moveBg = SKAction.moveBy(x: -bgTexture.size().width, y: 0, duration: 3)
        let replaceBg = SKAction.moveBy(x: bgTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatForever(SKAction.sequence([moveBg, replaceBg]))
        
        for i in 0..<3 {
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: size.width/4 + bgTexture.size().width * CGFloat(i), y: size.height/correctHeight)
            bg.size.height = self.frame.height
            bg.run(moveBgForever)
            bg.zPosition = -1
            
            bgObject.addChild(bg)
        }
    }
    
    func createGround() {
        ground = SKSpriteNode()
        ground.position = CGPoint.zero
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height/4 + self.frame.height/8))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundGroup
        ground.zPosition = 1
        
        groundObject.addChild(ground)
    }
    
    func createSky() {
        sky = SKSpriteNode()
        sky.position = CGPoint(x: 0, y: self.frame.maxX)
        sky.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width + 100, height: self.frame.size.height - 100))
        sky.physicsBody?.isDynamic = false
        sky.zPosition = 1
        
        movingObject.addChild(sky)
    }
    
    func addHero(heroNode: SKSpriteNode, atPosition position: CGPoint) {
        hero = SKSpriteNode(texture: flyHeroTex)
        
        //Anim hero
        heroFlyTexturesArray = [SKTexture(imageNamed: "Images/scene.atlas/Fly0.png"), SKTexture(imageNamed: "Images/scene.atlas/Fly1.png"), SKTexture(imageNamed: "Images/scene.atlas/Fly2.png"), SKTexture(imageNamed: "Images/scene.atlas/Fly3.png"), SKTexture(imageNamed: "Images/scene.atlas/Fly4.png")]
        let heroFlyAnimation = SKAction.animate(with: heroFlyTexturesArray, timePerFrame: 0.1)
        let flyHero = SKAction.repeatForever(heroFlyAnimation)
        hero.run(flyHero)
        
        hero.position = position
        hero.size.height = 84
        hero.size.width = 120
        
        hero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hero.size.width - 40, height: hero.size.height - 30))
        
        hero.physicsBody?.categoryBitMask = heroGroup
        hero.physicsBody?.contactTestBitMask = groundGroup | coinGroup | redCoinGroup | objectGroup | shieldGroup | rocketGroup
        hero.physicsBody?.collisionBitMask = groundGroup
        
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.allowsRotation = false
        hero.zPosition = 1
        
        heroObject.addChild(hero)
    }
    
    func createHero() {
        addHero(heroNode: hero, atPosition: CGPoint(x: self.size.width/4, y: 0 + flyHeroTex.size().height + 400))
    }
    
    func createHeroEmitter() {
        heroEmitter2 = SKEmitterNode(fileNamed: "VFX/engine.sks")!
        heroEmitterObject.zPosition = 1
        heroEmitterObject.addChild(heroEmitter2)
    }
    
    @objc func addCoin() {
        coin = SKSpriteNode(texture: coinTexture)
        
        coinTexturesArray = [SKTexture(imageNamed: "Images/scene.atlas/Coin0.png"), SKTexture(imageNamed: "Images/scene.atlas/Coin1.png"), SKTexture(imageNamed: "Images/scene.atlas/Coin2.png"), SKTexture(imageNamed: "Images/scene.atlas/Coin3.png")]
        
        let coinAnimation = SKAction.animate(with: coinTexturesArray, timePerFrame: 0.1)
        let coinHero = SKAction.repeatForever(coinAnimation)
        coin.run(coinHero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        coin.size.width = 40
        coin.size.height = 40
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width - 20, height: coin.size.height - 20))
        coin.physicsBody?.restitution = 0
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 90 + pipeOffset)
        
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        coin.run(coinMoveBgForever)
        
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinGroup
        coin.zPosition = 1
        coinObject.addChild(coin)
    }
    
    @objc func redCoinAdd() {
        redCoin = SKSpriteNode(texture: redCoinTexture)
        
        coinTexturesArray = [SKTexture(imageNamed: "Images/scene.atlas/Coin0.png"), SKTexture(imageNamed: "Images/scene.atlas/Coin1.png"), SKTexture(imageNamed: "Images/scene.atlas/Coin2.png"), SKTexture(imageNamed: "Images/scene.atlas/Coin3.png")]
        
        let redCoinAnimation = SKAction.animate(with: coinTexturesArray, timePerFrame: 0.1)
        let redCoinHero = SKAction.repeatForever(redCoinAnimation)
        redCoin.run(redCoinHero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        redCoin.size.width = 40
        redCoin.size.height = 40
        redCoin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: redCoin.size.width - 10, height: redCoin.size.height - 10))
        redCoin.physicsBody?.restitution = 0
        redCoin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 90 + pipeOffset)
        
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        redCoin.run(coinMoveBgForever)
        animations.scaleZdirection(sprite: redCoin)
        animations.redColorAnimation(sprite: redCoin, animDuration: 0.5)
        redCoin.setScale(1.3)
        redCoin.physicsBody?.isDynamic = false
        redCoin.physicsBody?.categoryBitMask = redCoinGroup
        redCoin.zPosition = 1
        redCoinObject.addChild(redCoin)
    }
    
    @objc func addElectricGate() {
        if Model.sharedInstance.sound == true {
            run(electricGateCreatePreload)
        }
        
        electricGate = SKSpriteNode(texture: electricGateTex)
        
        electricGateTexturesArray = [SKTexture(imageNamed: "Images/scene.atlas/ElectricGate01.png"), SKTexture(imageNamed: "Images/scene.atlas/ElectricGate02.png"), SKTexture(imageNamed: "Images/scene.atlas/ElectricGate03.png"), SKTexture(imageNamed: "Images/scene.atlas/ElectricGate04.png")]
        
        let electricGateAnimation = SKAction.animate(with: electricGateTexturesArray, timePerFrame: 0.1)
        let electricGateAnimationForever = SKAction.repeatForever(electricGateAnimation)
        electricGate.run(electricGateAnimationForever)
        
        let randomPosition = arc4random() % 2
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 5)
        let pipeOffset = self.frame.size.height / 4 + 30 - CGFloat(movementAmount)
        
        if randomPosition == 0 {
            electricGate.position = CGPoint(x: self.size.width + 50, y: 0 + electricGateTex.size().height/2 + 90 + pipeOffset)
            electricGate.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: electricGate.size.width - 40, height: electricGate.size.height - 20))
        } else {
            electricGate.position = CGPoint(x: self.size.width + 50, y: self.frame.size.height - electricGateTex.size().height/2 - 90 - pipeOffset)
            electricGate.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: electricGate.size.width - 40, height: electricGate.size.height - 20))
        }
        
        //Rotate
        electricGate.run(SKAction.repeatForever(SKAction.sequence([SKAction.run({
            self.electricGate.run(SKAction.rotate(byAngle: (CGFloat.pi * 2.0), duration: 0.5))
        }), SKAction.wait(forDuration: 20.0)])))
        
        //Move
        let moveAction = SKAction.moveBy(x: -self.frame.width - 300, y: 0, duration: 6)
        electricGate.run(moveAction)
        
        //Scale
        var scaleValue: CGFloat = 0.3
        
        
        let scaleRandom = arc4random() % UInt32(5)
        if scaleRandom == 1 { scaleValue = 0.9 }
        else if scaleRandom == 2 { scaleValue = 0.6 }
        else if scaleRandom == 3 { scaleValue = 0.8 }
        else if scaleRandom == 4 { scaleValue = 0.7 }
        else if scaleRandom == 0 { scaleValue = 1.0 }
        
        electricGate.setScale(scaleValue)
        
        let movementRandom = arc4random() % 9
        if movementRandom == 0 {
            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 + 220, duration: 4)
        } else if movementRandom == 1 {
            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 - 220, duration: 5)
        } else if movementRandom == 2 {
            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 - 150, duration: 4)
        } else if movementRandom == 3 {
            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 + 150, duration: 5)
        } else if movementRandom == 4 {
            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 + 50, duration: 4)
        } else if movementRandom == 5 {
            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 - 50, duration: 5)
        } else {
            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2, duration: 4)
        }
        
        electricGate.run(moveElectricGateY)
        
        electricGate.physicsBody?.restitution = 0
        electricGate.physicsBody?.isDynamic = false
        electricGate.physicsBody?.categoryBitMask = objectGroup
        electricGate.zPosition = 1
        movingObject.addChild(electricGate)
    }
    
    @objc func addMine() {
        mine = SKSpriteNode(texture: mineTexture1)
        let minesRandom = arc4random() % UInt32(2)
        if minesRandom == 0 {
            mine = SKSpriteNode(texture: mineTexture1)
        } else {
            mine = SKSpriteNode(texture: mineTexture2)
        }
        
        mine.size.width = 70
        mine.size.height = 62
        mine.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24)
        
        let moveMineX = SKAction.moveTo(x: -self.frame.size.width / 4, duration: 4)
        mine.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mine.size.width - 40, height: mine.size.height - 30))
        mine.physicsBody?.categoryBitMask = objectGroup
        mine.physicsBody?.isDynamic = false
        
        let removeAction = SKAction.removeFromParent()
        let mineMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveMineX, removeAction]))
        
        animations.rotateAnimationToAngle(sprite: mine, animDuration: 0.2)
        
        mine.run(mineMoveBgForever)
        mine.zPosition = 1
        movingObject.addChild(mine)
    }
    
    func addShield() {
        shield = SKSpriteNode(texture: shieldTexture)
        if Model.sharedInstance.sound == true { run(shieldOnPreload) }
        shield.zPosition = 1
        shieldObject.addChild(shield)
    }
    
    @objc func addShieldItem() {
        shieldItem = SKSpriteNode(texture: shieldItemTexture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        shieldItem.position = CGPoint(x: self.size.width + 50, y: 0 + shieldItemTexture.size().height + self.size.height / 2 + pipeOffset)
        shieldItem.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shieldItem.size.width - 20, height: shieldItem.size.height - 20))
        shieldItem.physicsBody?.restitution = 0
        
        let moveShield = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let shieldItemMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveShield, removeAction]))
        shieldItem.run(shieldItemMoveBgForever)
        
        animations.scaleZdirection(sprite: shieldItem)
        shieldItem.setScale(1.1)
        
        shieldItem.physicsBody?.isDynamic = false
        shieldItem.physicsBody?.categoryBitMask = shieldGroup
        shieldItem.zPosition = 1
        shieldItemObject.addChild(shieldItem)
        
    }
    
    @objc func addRocket() {
        
        rocket = SKSpriteNode(texture: rocketTex)
        rocket.size.width = 180
        rocket.size.height = 55
        
        if Model.sharedInstance.sound == true { run(rocketCreatePreload) }
        
        let movementRandom = arc4random() % 8
        if movementRandom == 0 {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 + 220)
        } else if movementRandom == 1 {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 - 220)
        } else if movementRandom == 2 {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 + 120)
        } else if movementRandom == 3 {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 - 120)
        } else if movementRandom == 4 {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 + 50)
        } else if movementRandom == 5 {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 - 50)
        } else {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2)
        }
        
        let moveFuze = SKAction.moveTo( x: -self.frame.size.width / 4 , duration: 4)
        
        rocketTexturesArray = [SKTexture(imageNamed: "Images/scene.atlas/Rocket0"),SKTexture(imageNamed: "Images/scene.atlas/Rocket1"),SKTexture(imageNamed: "Images/scene.atlas/Rocket2"),SKTexture(imageNamed: "Images/scene.atlas/Rocket3"),SKTexture(imageNamed: "Images/scene.atlas/Rocket4"),SKTexture(imageNamed: "Images/scene.atlas/Rocket5")]
        
        let rocketAnimation = SKAction.animate(with: rocketTexturesArray, timePerFrame: 0.1)
        
        let flyFuze = SKAction.repeatForever(rocketAnimation)
        
        rocket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rocket.size.width - 20 , height: rocket.size.height - 10))
        
        rocket.physicsBody?.categoryBitMask = rocketGroup
        
        rocket.physicsBody?.isDynamic = false
        
        let maxAspectRatio:CGFloat = 16.0/9.0 // iPhone 5"
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-maxAspectRatioHeight)/2.0
        let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height-playableMargin*2)
        let removeAction = SKAction.removeFromParent()
        let rocketMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveFuze,removeAction]))
        
        switch stageLabel.text! {
        case "Stage 1":
            rangeRocket = 0.10
        case "Stage 2":
            rangeRocket = 0.13
        case "Stage 3":
            rangeRocket = 0.15
        default:break
        }
        
        rocket.run(SKAction.repeat(
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: playableRect.height * rangeRocket, duration: 1.0),
                SKAction.moveBy(x: 0, y: -playableRect.height * rangeRocket, duration: 1.0)
            ]), count:4
        ))
        
        rocket.run(rocketMoveBgForever)
        rocket.run(flyFuze)
        
        rocket.zPosition = 1
        
        rocketObject.addChild(rocket)
    }
    
    func showTapToPlay() {
        tabToPlayLabel.text = "Tap to Fly!!!"
        tabToPlayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        tabToPlayLabel.fontSize = 50
        tabToPlayLabel.fontColor = UIColor.white
        tabToPlayLabel.fontName = "Chalkduster"
        tabToPlayLabel.zPosition = 1
        self.addChild(tabToPlayLabel)
    }
    
    func showScore() {
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
    }
    
    func showHighscore() {
        highscoreLabel = SKLabelNode()
        highscoreLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 210)
        highscoreLabel.fontSize = 50
        highscoreLabel.fontName = "Chalkduster"
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.isHidden = true
        highscoreLabel.zPosition = 1
        labelObject.addChild(highscoreLabel)
    }
    
    func showHighscoreText() {
        //highscoreTextLabel = SKLabelNode()
        highscoreTextLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 150)
        highscoreTextLabel.fontSize = 30
        highscoreTextLabel.fontName = "Chalkduster"
        highscoreTextLabel.fontColor = UIColor.white
        highscoreTextLabel.text = "HighScore"
        highscoreTextLabel.zPosition = 1
        labelObject.addChild(highscoreTextLabel)
    }
    
    func showStage() {
        stageLabel.position = CGPoint(x: self.frame.maxX - 60, y: self.frame.maxY - 140)
        stageLabel.fontSize = 30
        stageLabel.fontName = "Chalkduster"
        stageLabel.fontColor = UIColor.white
        stageLabel.text = "Stage 1"
        stageLabel.zPosition = 1
        self.addChild(stageLabel)
    }
    
    func levelUp() {
        if 1 <= Model.sharedInstance.score && Model.sharedInstance.score < 20 {
            stageLabel.text = "Stage 1"
            coinObject.speed = 1.05
            redCoinObject.speed = 1.1
            movingObject.speed = 1.05
            rocketObject.speed = 1.05
            self.speed = 1.05
        } else if 20 <= Model.sharedInstance.score && Model.sharedInstance.score < 36 {
            stageLabel.text = "Stage 2"
            coinObject.speed = 1.22
            redCoinObject.speed = 1.32
            movingObject.speed = -1.22
            rocketObject.speed = 1.22
            self.speed = 1.22
        } else if 36 <= Model.sharedInstance.score && Model.sharedInstance.score < 56 {
            stageLabel.text = "Stage 3"
            coinObject.speed = 1.3
            redCoinObject.speed = 1.35
            movingObject.speed = 1.3
            rocketObject.speed = 1.3
            self.speed = 1.3
        }
    }
    
    func timerFunc() {
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        timerAddMine.invalidate()
        timerAddShieldItem.invalidate()
        timerAddRocket.invalidate()
        
        timerAddCoin = Timer.scheduledTimer(timeInterval: 2.64, target: self, selector: #selector(GameScene.addCoin), userInfo: nil, repeats: true)
        timerAddRedCoin = Timer.scheduledTimer(timeInterval: 8.246, target: self, selector: #selector(GameScene.redCoinAdd), userInfo: nil, repeats: true)
        
        switch gSceneDifficulty.rawValue {
        case 0: //easy mode
            timerAddElectricGate = Timer.scheduledTimer(timeInterval: 5.234, target: self, selector: #selector(GameScene.addElectricGate), userInfo: nil, repeats: true)
            timerAddMine = Timer.scheduledTimer(timeInterval: 4.245, target: self, selector: #selector(GameScene.addMine), userInfo: nil, repeats: true)
            timerAddRocket = Timer.scheduledTimer(timeInterval: 3.743, target: self, selector: #selector(GameScene.addRocket), userInfo: nil, repeats: true)
            
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 20.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
        case 1: //medium mode
            timerAddElectricGate = Timer.scheduledTimer(timeInterval: 3.234, target: self, selector: #selector(GameScene.addElectricGate), userInfo: nil, repeats: true)
            timerAddMine = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addMine), userInfo: nil, repeats: true)
            timerAddRocket = Timer.scheduledTimer(timeInterval: 2.743, target: self, selector: #selector(GameScene.addRocket), userInfo: nil, repeats: true)
            
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 30.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
        case 2: //hard mode
            timerAddElectricGate = Timer.scheduledTimer(timeInterval: 3.034, target: self, selector: #selector(GameScene.addElectricGate), userInfo: nil, repeats: true)
            timerAddMine = Timer.scheduledTimer(timeInterval: 2.945, target: self, selector: #selector(GameScene.addMine), userInfo: nil, repeats: true)
            timerAddRocket = Timer.scheduledTimer(timeInterval: 2.543, target: self, selector: #selector(GameScene.addRocket), userInfo: nil, repeats: true)
            
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 40.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
        default: break
        }
    }
    
    func stopGameObject() {
        coinObject.speed = 0
        redCoinObject.speed = 0
        movingObject.speed = 0
        heroObject.speed = 0
        rocketObject.speed = 0
    }
    
    func reloadGame() {
        
        if Model.sharedInstance.sound == true {
            SKTAudio.sharedInstance().resumeBackgroundMusic()
        }
        
        coinObject.removeAllChildren()
        redCoinObject.removeAllChildren()
        
        stageLabel.text = "Stage 1"
        gameover = 0
        scene?.isPaused = false
        
        movingObject.removeAllChildren()
        rocketObject.removeAllChildren()
        heroObject.removeAllChildren()
        
        coinObject.speed = 1
        heroObject.speed = 1
        movingObject.speed = 1
        rocketObject.speed = 1
        self.speed = 1
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
        
        createGround()
        createSky()
        createHero()
        createHeroEmitter()
        
        gameViewControllerBridge.returnMainBtn.isHidden = true
        
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        stageLabel.isHidden = false
        highscoreTextLabel.isHidden = true
        showHighscore()
        
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        timerAddMine.invalidate()
        timerAddShieldItem.invalidate()
        timerAddRocket.invalidate()
        
        timerFunc()
    }
    
    public override func didFinishUpdate() {
        heroEmitter2.position = hero.position - CGPoint(x: 30, y: 5)
        shield.position = hero.position + CGPoint(x: 0, y: 0)
    }
    
    func removeAll() {
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        
        gameover = 0
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
        
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        timerAddMine.invalidate()
        timerAddShieldItem.invalidate()
        timerAddRocket.invalidate()
        
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        self.view?.removeFromSuperview()
        gameViewControllerBridge = nil
    }
}
