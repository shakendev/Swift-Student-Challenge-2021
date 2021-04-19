// MARK: - Import section

// Importing the UIKit framework
import UIKit




// MARK: - Class declaration and implementation

// Creating a screen with a level selection
public final class LevelSelectionViewController: UIViewController {
    
    // MARK: Declaring properties
    
    // Difficulty
    var selectBgDifficulty: DifficultyChoosing!
    
    // Total points label
    private let totalPoints: UILabel = {
        let label = UILabel()
        label.text = "Total Points: "
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 1
        label.isUserInteractionEnabled = false
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    // Blur visual effect view
    private let blurVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .light)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Vibrancy visual effect view
    private let vibrancyVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light), style: .label)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Horizontal stack view
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 50.0
        stackView.isUserInteractionEnabled = true
        stackView.clipsToBounds = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Level buttons
    private lazy var levelButtons: [UIButton] = {
        let buttons = [
            UIButton(type: .custom),
            UIButton(type: .custom)
        ]
        for i in 0 ..< buttons.count {
            buttons[i].setImage(UIImage(named: "Images/Backgrounds/Levels/Level #\(i + 1)/Level Background #\(i + 1).png"), for: .normal)
            buttons[i].setImage(UIImage(named: "Images/Backgrounds/Levels/Level #\(i + 1)/Level Background #\(i + 1).png"), for: .highlighted)
            buttons[i].tag = i
            buttons[i].layer.cornerRadius = 25.0
            buttons[i].addTarget(self, action: #selector(self.levelSelectionButtonsTouchDown(sender:)), for: .touchDown)
            buttons[i].addTarget(self, action: #selector(self.levelSelectionButtonsTouchUpOutside(sender:)), for: .touchUpOutside)
            buttons[i].addTarget(self, action: #selector(self.levelSelectionButtonsTouchUpInside(sender:)), for: .touchUpInside)
            buttons[i].isUserInteractionEnabled = true
            buttons[i].clipsToBounds = true
            buttons[i].translatesAutoresizingMaskIntoConstraints = false
        }
        buttons[1].isUserInteractionEnabled = false
        return buttons
    }()
    
    // Second level blur visual effect view
    private let secondLevelBlurVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .dark)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Second level vibrancy visual effect view
    private let secondLevelVibrancyVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .dark), style: .label)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Second level unlock label
    private let secondLevelUnlockLabel: UILabel = {
        let label = UILabel()
        label.text =
"""
Get \(Model.sharedInstance.level2UnlockValue) points
to unlock level
"""
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 2
        label.isUserInteractionEnabled = false
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Back button
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        button.layer.borderWidth = 3.0
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 13.0
        button.addTarget(self, action: #selector(self.backButtonTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.backButtonTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.backButtonTouchUpInside(sender:)), for: .touchUpInside)
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
        
    }
    
    //
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Continuation of background music
        if Model.sharedInstance.sound == true {
            SKTAudio.sharedInstance().resumeBackgroundMusic()
        }
        
        // Update the number of points
        totalPoints.text = "Total Points: \(Model.sharedInstance.totalscore)"
        
        // Definition of accessibility to the second level
        if Model.sharedInstance.totalscore > Model.sharedInstance.level2UnlockValue {
            self.secondLevelBlurVisualEffectView.isHidden = true
            self.levelButtons[1].isUserInteractionEnabled = true
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
        
        // Total points label
        self.vibrancyVisualEffectView.contentView.addSubview(self.totalPoints)
        
        // Horizontal stack view
        self.blurVisualEffectView.contentView.addSubview(self.horizontalStackView)
        
        // Level buttons
        for button in self.levelButtons {
            self.horizontalStackView.addArrangedSubview(button)
        }
        
        // Second level blur visual effect view
        self.levelButtons[1].addSubview(self.secondLevelBlurVisualEffectView)
        
        // Second level vibrancy visual effect view
        self.secondLevelBlurVisualEffectView.contentView.addSubview(self.secondLevelVibrancyVisualEffectView)
        
        // Second level unlock label
        self.secondLevelVibrancyVisualEffectView.contentView.addSubview(self.secondLevelUnlockLabel)
        
        // Back button
        self.vibrancyVisualEffectView.contentView.addSubview(self.backButton)
        
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
        
        // Total points label
        NSLayoutConstraint.activate([
            self.totalPoints.centerXAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.centerXAnchor),
            self.totalPoints.topAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.topAnchor, constant: 20.0)
        ])
        
        // Horizontal stack view
        NSLayoutConstraint.activate([
            self.horizontalStackView.centerXAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.centerXAnchor),
            self.horizontalStackView.centerYAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.centerYAnchor, constant: -20.0),
            self.horizontalStackView.widthAnchor.constraint(equalToConstant: 490.0),
            self.horizontalStackView.heightAnchor.constraint(equalToConstant: 170.0)
        ])
        
        // Second level blur visual effect view
        NSLayoutConstraint.activate([
            self.secondLevelBlurVisualEffectView.topAnchor.constraint(equalTo: self.levelButtons[1].topAnchor),
            self.secondLevelBlurVisualEffectView.leadingAnchor.constraint(equalTo: self.levelButtons[1].leadingAnchor),
            self.secondLevelBlurVisualEffectView.trailingAnchor.constraint(equalTo: self.levelButtons[1].trailingAnchor),
            self.secondLevelBlurVisualEffectView.bottomAnchor.constraint(equalTo: self.levelButtons[1].bottomAnchor)
        ])
        
        // Second level vibrancy visual effect view
        NSLayoutConstraint.activate([
            self.secondLevelVibrancyVisualEffectView.topAnchor.constraint(equalTo: self.secondLevelBlurVisualEffectView.contentView.topAnchor),
            self.secondLevelVibrancyVisualEffectView.leadingAnchor.constraint(equalTo: self.secondLevelBlurVisualEffectView.contentView.leadingAnchor),
            self.secondLevelVibrancyVisualEffectView.trailingAnchor.constraint(equalTo: self.secondLevelBlurVisualEffectView.contentView.trailingAnchor),
            self.secondLevelVibrancyVisualEffectView.bottomAnchor.constraint(equalTo: self.secondLevelBlurVisualEffectView.contentView.bottomAnchor)
        ])
        
        // Second level unlock label
        NSLayoutConstraint.activate([
            self.secondLevelUnlockLabel.topAnchor.constraint(equalTo: self.secondLevelVibrancyVisualEffectView.contentView.topAnchor),
            self.secondLevelUnlockLabel.leadingAnchor.constraint(equalTo: self.secondLevelVibrancyVisualEffectView.contentView.leadingAnchor),
            self.secondLevelUnlockLabel.trailingAnchor.constraint(equalTo: self.secondLevelVibrancyVisualEffectView.contentView.trailingAnchor),
            self.secondLevelUnlockLabel.bottomAnchor.constraint(equalTo: self.secondLevelVibrancyVisualEffectView.contentView.bottomAnchor)
        ])
        
        // Back button
        NSLayoutConstraint.activate([
            self.backButton.centerXAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.centerXAnchor),
            self.backButton.bottomAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.bottomAnchor, constant: -60.0),
            self.backButton.widthAnchor.constraint(equalToConstant: 94.0),
            self.backButton.heightAnchor.constraint(equalToConstant: 47.0)
        ])
        
    }
    
    
    
    
    // MARK: Declaring event handlers
    
    // Level selection buttons touch down
    @objc
    private func levelSelectionButtonsTouchDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        SKTAudio.sharedInstance().playSoundEffect(filename: "SFX/Sounds/Button/Clicked Button Sound.mp3")
    }
    
    // Level selection buttons touch up outside
    @objc
    private func levelSelectionButtonsTouchUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: .curveEaseOut) {
            sender.transform = .identity
        }
    }
    
    // Level selection buttons touch up inside
    @objc
    private func levelSelectionButtonsTouchUpInside(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen
        gameViewController.modalTransitionStyle = .flipHorizontal
        
        gameViewController.gVCBgChoosing = BgChoosing(rawValue: sender.tag)!
        gameViewController.gVCDifficulty = selectBgDifficulty
        
        if gameViewController.gVCBgChoosing.rawValue == 0 {
            self.present(gameViewController, animated: false, completion: nil)
        } else if gameViewController.gVCBgChoosing.rawValue == 1 && Model.sharedInstance.totalscore > Model.sharedInstance.level2UnlockValue {
            self.present(gameViewController, animated: false, completion: nil)
        }
    }
    
    // Back button touch down
    @objc
    private func backButtonTouchDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.backButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        SKTAudio.sharedInstance().playSoundEffect(filename: "SFX/Sounds/Button/Back Button Sound.mp3")
    }
    
    // Back button touch up outside
    @objc
    private func backButtonTouchUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: .curveEaseOut) {
            self.backButton.transform = .identity
        }
    }
    
    // Back button touch up inside
    @objc
    private func backButtonTouchUpInside(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.backButton.transform = .identity
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
