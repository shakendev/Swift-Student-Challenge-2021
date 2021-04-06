/*
 *
 *    Xcode Playground Project
 *
 *    - - - - - - - - - -
 *
 *    Developed specifically & only for WWDC21
 *
 *    - - - - - - - - - -
 *
 *    Name: Backend Boy
 *
 *    Genre: 2D platformer with specially stylized design for WWDC21
 *
 *    Game Design: Specially stylized design based on the WWDC theme
 *
 *    Environment: 2D Screen Space
 *
 *    Target Platform: Xcode Playground
 *
 *    User Experience: You can always think that everything is good [🙂], when in fact everything is bad [☹️].
 *
 *    Game Description: краткое описание игры
 *
 *    Game Goal: цель игры
 *
 *    Game Credits: кредитс по игре откуда взята музыка звуки ассеты и картинки и тд
 *
 *    - - - - - - - - - -
 *
 *    Author:
 *        Created by Dimka Novikov on 04.04.2021
 *        Copyright © 2021 //DDEC. All Rights Not Reserved.     :)
 *
 *    - - - - - - - - - -
 *
 *    Country: Russia
 *    Hometown: Yuzhno-Sakhalinsk     😎
 *
 *    University:
 *        Location: St. Petersburg     🤓
 *        Information:
 *            let universityName = (key: "itmo",
 *                                  name: "ITMO University",
 *                                  description: "🤡")
 *            let studyDirection = (key: "GameDev",
 *                                  name: "Computer game development technologies",
 *                                  description: "🎮")
 *
 *    - - - - - - - - - -
 *
 *    Software & Hardware, which were used for testing:
 *
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *    |     Model |       |  MacBook Air 13" 2017       |  MacBook Pro 13" 2019 (Two TB Ports)  |
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *    |  Software |   OS: |  macOS Big Sur 11.1         |  macOS Big Sur 11.2.3                 |
 *    |           |  IDE: |  Xcode 12.4                 |  Xcode 12.4                           |
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *    |  Hardware |  CPU: |  Intel Core i7              |  Intel Core i7                        |
 *    |           |  RAM: |  8 GB LPDDR3                |  16 GB LPDDR3                         |
 *    |           |  GPU: |  0: Intel HD Graphics 6000  |  0: Intel Iris Plus Graphics 645      |
 *    |           |       |                             |  1: AMD Radeon RX 580                 |
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *
 */




// MARK: - Import section

// Importing a PlaygroundSupport framework
import PlaygroundSupport




// MARK: - UIViewController live preview

// Create live preview for MainMenuViewController
PlaygroundPage.current.liveView = MainMenuViewController()







////: A SpriteKit based Playground
//
//import PlaygroundSupport
//import SpriteKit
//
//class GameScene: SKScene {
//
//    private var label : SKLabelNode!
//    private var spinnyNode : SKShapeNode!
//
//    override func didMove(to view: SKView) {
//        // Get label node from scene and store it for use later
//        label = childNode(withName: "//helloLabel") as? SKLabelNode
//        label.alpha = 0.0
//        let fadeInOut = SKAction.sequence([.fadeIn(withDuration: 2.0),
//                                           .fadeOut(withDuration: 2.0)])
//        label.run(.repeatForever(fadeInOut))
//
//        // Create shape node to use during mouse interaction
//        let w = (size.width + size.height) * 0.05
//
//        spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)
//        spinnyNode.lineWidth = 2.5
//
//        let fadeAndRemove = SKAction.sequence([.wait(forDuration: 0.5),
//                                               .fadeOut(withDuration: 0.5),
//                                               .removeFromParent()])
//        spinnyNode.run(.repeatForever(.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//        spinnyNode.run(fadeAndRemove)
//    }
//
//    @objc static override var supportsSecureCoding: Bool {
//        // SKNode conforms to NSSecureCoding, so any subclass going
//        // through the decoding process must support secure coding
//        get {
//            return true
//        }
//    }
//
//    func touchDown(atPoint pos : CGPoint) {
//        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
//
//        n.position = pos
//        n.strokeColor = SKColor.green
//        addChild(n)
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        guard let n = self.spinnyNode.copy() as? SKShapeNode else { return }
//
//        n.position = pos
//        n.strokeColor = SKColor.blue
//        addChild(n)
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
//
//        n.position = pos
//        n.strokeColor = SKColor.red
//        addChild(n)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
//}
//
//// Load the SKScene from 'GameScene.sks'
//let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
//if let scene = GameScene(fileNamed: "GameScene") {
//    // Set the scale mode to scale to fit the window
//    scene.scaleMode = .aspectFill
//
//    // Present the scene
//    sceneView.presentScene(scene)
//}
//
//PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
