// MARK: - Import section

// Importing a SpriteKit framework
import SpriteKit




// MARK: - Class declaration and implementation

// Creating an InitialScene
public final class InitialScene: SKScene {
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.setupParticleEmitter()
        
    }
    
    
    private func setupParticleEmitter() {
        let particleEmitter = SKEmitterNode(fileNamed: "VFX/SnowParticle.sks")!

        particleEmitter.position = CGPoint(x: size.width / 2, y: size.height)

        self.addChild(particleEmitter)

    }
    
}
