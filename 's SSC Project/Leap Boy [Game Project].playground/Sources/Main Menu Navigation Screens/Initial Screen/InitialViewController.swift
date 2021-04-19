// MARK: - Import section

// Importing the UIKit framework
import UIKit




// MARK: - Class declaration and implementation

// Creating an initial screen
public final class InitialViewController: UIViewController {
    
    // MARK: Declaring properties
    
    // Background image view
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Images/Backgrounds/Main Menu/Main Menu Background.png")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Blur Visual Effect View
    private let blurVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .light)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Vibrancy Visual Effect View
    private let vibrancyVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light), style: .label)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Game title label
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.text =
"""
Welcome to the Leap Boy
WWDC21
"""
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 2
        label.isUserInteractionEnabled = false
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Play game button
    private lazy var playGameButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Play Game", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        button.layer.borderWidth = 3.0
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 13.0
        button.addTarget(self, action: #selector(self.playGameButtonTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.playGameButtonTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.playGameButtonTouchUpInside(sender:)), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    // MARK: Overriding parent methods
    
    // Initial setting of view sizes
    public override func loadView() {
        
        self.view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 700.0, height: 450.0))
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    // Screen customization
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.customizeLayout()
        
        // Reading total score
        if UserDefaults.standard.object(forKey: "totalscore") != nil {
            Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalscore") as! Int
        }
        
        // Turning on background music
        if Model.sharedInstance.sound == true {
            SKTAudio.sharedInstance().playBackgroundMusic(filename: "SFX/Music/Main Menu Theme/Main Menu Theme.mp3")
        }
        
    }
    
    
    
    
    // MARK: Declaring methods
    
    // Setting up views
    private func setupViews() {
        
        // Background image view
        self.view.addSubview(self.backgroundImageView)
        
        // Blur Visual Effect View
        self.view.addSubview(self.blurVisualEffectView)
        
        // Vibrancy Visual Effect View
        self.blurVisualEffectView.contentView.addSubview(self.vibrancyVisualEffectView)
        
        // Game title label
        self.vibrancyVisualEffectView.contentView.addSubview(self.gameTitleLabel)
        
        // Play game button
        self.vibrancyVisualEffectView.contentView.addSubview(self.playGameButton)
        
    }
    
    // Customize layout
    private func customizeLayout() {
        
        // Background image view
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        // Blur Visual Effect View
        NSLayoutConstraint.activate([
            self.blurVisualEffectView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.blurVisualEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.blurVisualEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.blurVisualEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        // Vibrancy Visual Effect View
        NSLayoutConstraint.activate([
            self.vibrancyVisualEffectView.topAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.topAnchor),
            self.vibrancyVisualEffectView.leadingAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.leadingAnchor),
            self.vibrancyVisualEffectView.trailingAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.trailingAnchor),
            self.vibrancyVisualEffectView.bottomAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.bottomAnchor)
        ])
        
        // Game title label
        NSLayoutConstraint.activate([
            self.gameTitleLabel.centerXAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.centerXAnchor),
            self.gameTitleLabel.centerYAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.centerYAnchor, constant: -40.0),
            self.gameTitleLabel.widthAnchor.constraint(equalToConstant: 550.0),
            self.gameTitleLabel.heightAnchor.constraint(equalToConstant: 100.0)
        ])
        
        // Play game button
        NSLayoutConstraint.activate([
            self.playGameButton.topAnchor.constraint(equalTo: self.gameTitleLabel.bottomAnchor, constant: 30.0),
            self.playGameButton.centerXAnchor.constraint(equalTo: self.gameTitleLabel.centerXAnchor),
            self.playGameButton.widthAnchor.constraint(equalToConstant: 180.0),
            self.playGameButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
    }
    
    
    
    
    // MARK: Declaring event handlers
    
    // Play game button touch down
    @objc
    private func playGameButtonTouchDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.playGameButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        SKTAudio.sharedInstance().playSoundEffect(filename: "SFX/Sounds/Button/Clicked Button Sound.mp3")
    }
    
    // Play game button touch up outside
    @objc
    private func playGameButtonTouchUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: .curveEaseOut) {
            self.playGameButton.transform = .identity
        }
    }
    
    // Play game button touch up inside
    @objc
    private func playGameButtonTouchUpInside(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.playGameButton.transform = .identity
        }
        let difficultyLevelViewController = DifficultyLevelViewController()
        difficultyLevelViewController.modalPresentationStyle = .fullScreen
        difficultyLevelViewController.modalTransitionStyle = .flipHorizontal
        self.present(difficultyLevelViewController, animated: true, completion: nil)
    }
    
}
