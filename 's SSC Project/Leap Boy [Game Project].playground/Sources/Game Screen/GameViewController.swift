// MARK: - Import section

// Importing the UIKit framework
import SpriteKit




// MARK: - Class declaration and implementation

// Creating a screen with a game level
public final class GameViewController: UIViewController {
    
    var scene = GameScene(size: CGSize(width: 1024, height: 768))
    let textureAtlas = SKTextureAtlas(named: "Images/scene.atlas")
    
    //Variables
    var gVCBgChoosing: BgChoosing!
    var gVCDifficulty: DifficultyChoosing!
    
    public lazy var returnMainBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "Images/Menu Buttons/mainmenuButton.png"), for: .normal)
        button.addTarget(self, action: #selector(self.returnMainButtonTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.returnMainButtonTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.returnMainButtonTouchUpInside(sender:)), for: .touchUpInside)
        button.isHidden = true
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var reloadGameBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "Images/Menu Buttons/reloadButton.png"), for: .normal)
        button.addTarget(self, action: #selector(self.reloadGameBtnTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.reloadGameBtnTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.reloadGameBtnTouchUpInside(sender:)), for: .touchUpInside)
        button.isHidden = true
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let loadingView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override func loadView() {
        self.view = SKView(frame: CGRect(x: 0.0, y: 0.0, width: 700.0, height: 450.0))
        self.view.backgroundColor = .black
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
        self.customizeLayout()
        
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        
        switch gVCBgChoosing.rawValue {
        case 1:
            SKTAudio.sharedInstance().playBackgroundMusic(filename: "SFX/Music/Level Themes/Level #2/Level Theme #2.mp3")
        default:
            SKTAudio.sharedInstance().playBackgroundMusic(filename: "SFX/Music/Level Themes/Level #1/Level Theme #1.mp3")
        }
        
        loadingView.isHidden = false
        SwiftSpinner.show(title: "Loading...", animated: true)
        
        reloadGameBtn.isHidden = true
        
        let skView = self.view as! SKView
        
        skView.ignoresSiblingOrder = true

        scene.scaleMode = .aspectFill
        scene.gSceneBg = gVCBgChoosing
        scene.gSceneDifficulty = gVCDifficulty
        scene.gameViewControllerBridge = self

        textureAtlas.preload {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                self.loadingView.isHidden = true
                SwiftSpinner.hide()
                skView.presentScene(self.scene)
            }
        }
    }
    
    
    private func setupViews() {
        
        self.view.addSubview(self.returnMainBtn)
        
        self.view.addSubview(self.reloadGameBtn)
        
    }
    
    // Customize layout
    private func customizeLayout() {
        
        NSLayoutConstraint.activate([
            self.returnMainBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.returnMainBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50.0),
            self.returnMainBtn.widthAnchor.constraint(equalToConstant: 70.0),
            self.returnMainBtn.heightAnchor.constraint(equalToConstant: 70.0)
        ])
        
        NSLayoutConstraint.activate([
            self.reloadGameBtn.centerXAnchor.constraint(equalTo: self.returnMainBtn.centerXAnchor),
            self.reloadGameBtn.topAnchor.constraint(equalTo: self.returnMainBtn.bottomAnchor, constant: 50.0),
            self.reloadGameBtn.widthAnchor.constraint(equalToConstant: 70.0),
            self.reloadGameBtn.heightAnchor.constraint(equalToConstant: 70.0)
        ])
        
    }
    
    
    
    
    // MARK: Declaring event handlers
    
    // Return main button touch down
    @objc
    private func returnMainButtonTouchDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        SKTAudio.sharedInstance().playSoundEffect(filename: "SFX/Sounds/Button/Back Button Sound.mp3")
    }
    
    // Return main button touch up outside
    @objc
    private func returnMainButtonTouchUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: .curveEaseOut) {
            sender.transform = .identity
        }
    }
    
    // Return main button touch up inside
    @objc
    private func returnMainButtonTouchUpInside(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "SFX/Music/Main Menu Theme/Main Menu Theme.mp3")
        self.dismiss(animated: false, completion: nil)
        DispatchQueue.main.async {
            self.scene.removeAll()
        }
    }
    
    // Reload game button touch down
    @objc
    private func reloadGameBtnTouchDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        SKTAudio.sharedInstance().playSoundEffect(filename: "SFX/Sounds/Button/Clicked Button Sound.mp3")
    }
    
    // Reload game button touch up outside
    @objc
    private func reloadGameBtnTouchUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: .curveEaseOut) {
            sender.transform = .identity
        }
    }
    
    // Reload game button touch up inside
    @objc
    private func reloadGameBtnTouchUpInside(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        scene.reloadGame()
        scene.gameViewControllerBridge = self
        reloadGameBtn.isHidden = true
    }
    
}
