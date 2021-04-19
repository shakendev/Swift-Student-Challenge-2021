// MARK: - Import section

// Importing the UIKit framework
import UIKit




// MARK: - Class declaration and implementation

// Creating a screen with difficulty levels
public final class DifficultyLevelViewController: UIViewController {
    
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
    
    // Easy complexity selection button
    private lazy var easyComplexitySelectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Easy", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 40.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        button.tag = 0
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchUpInside(sender:)), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Medium complexity selection button
    private lazy var mediumComplexitySelectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Medium", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 40.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        button.tag = 1
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchUpInside(sender:)), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Hard complexity selection button
    private lazy var hardComplexitySelectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Hard", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 40.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        button.tag = 2
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.difficultyLevelButtonsTouchUpInside(sender:)), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    
    
    
    // MARK: Declaring methods
    
    // Setting up views
    private func setupViews() {
        
        // Background image view
        self.view.addSubview(self.backgroundImageView)
        
        // Blur Visual Effect View
        self.view.addSubview(self.blurVisualEffectView)
        
        // Vibrancy Visual Effect View
        self.blurVisualEffectView.contentView.addSubview(self.vibrancyVisualEffectView)
        
        // Medium complexity selection button
        self.vibrancyVisualEffectView.contentView.addSubview(self.mediumComplexitySelectionButton)
        
        // Easy complexity selection button
        self.vibrancyVisualEffectView.contentView.addSubview(self.easyComplexitySelectionButton)
        
        // Hard complexity selection button
        self.vibrancyVisualEffectView.contentView.addSubview(self.hardComplexitySelectionButton)
        
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
        
        // Medium complexity selection button
        NSLayoutConstraint.activate([
            self.mediumComplexitySelectionButton.centerXAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.centerXAnchor),
            self.mediumComplexitySelectionButton.centerYAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.centerYAnchor, constant: -20.0),
            self.mediumComplexitySelectionButton.widthAnchor.constraint(equalToConstant: 180.0),
            self.mediumComplexitySelectionButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
        // Easy complexity selection button
        NSLayoutConstraint.activate([
            self.easyComplexitySelectionButton.centerXAnchor.constraint(equalTo: self.mediumComplexitySelectionButton.centerXAnchor),
            self.easyComplexitySelectionButton.bottomAnchor.constraint(equalTo: self.mediumComplexitySelectionButton.topAnchor, constant: -20.0),
            self.easyComplexitySelectionButton.widthAnchor.constraint(equalToConstant: 180.0),
            self.easyComplexitySelectionButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
        // Hard complexity selection button
        NSLayoutConstraint.activate([
            self.hardComplexitySelectionButton.centerXAnchor.constraint(equalTo: self.mediumComplexitySelectionButton.centerXAnchor),
            self.hardComplexitySelectionButton.topAnchor.constraint(equalTo: self.mediumComplexitySelectionButton.bottomAnchor, constant: 20.0),
            self.hardComplexitySelectionButton.widthAnchor.constraint(equalToConstant: 180.0),
            self.hardComplexitySelectionButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
        // Back button
        NSLayoutConstraint.activate([
            self.backButton.centerXAnchor.constraint(equalTo: self.hardComplexitySelectionButton.centerXAnchor),
            self.backButton.topAnchor.constraint(equalTo: self.hardComplexitySelectionButton.bottomAnchor, constant: 50.0),
            self.backButton.widthAnchor.constraint(equalToConstant: 94.0),
            self.backButton.heightAnchor.constraint(equalToConstant: 47.0)
        ])
        
    }
    
    
    
    
    // MARK: Declaring event handlers
    
    // Difficulty level buttons touch down
    @objc
    private func difficultyLevelButtonsTouchDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        SKTAudio.sharedInstance().playSoundEffect(filename: "SFX/Sounds/Button/Clicked Button Sound.mp3")
    }
    
    // Difficulty level buttons touch up outside
    @objc
    private func difficultyLevelButtonsTouchUpOutside(sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: .curveEaseOut) {
            sender.transform = .identity
        }
    }
    
    // Difficulty level buttons touch up inside
    @objc
    private func difficultyLevelButtonsTouchUpInside(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
        let levelSelectionViewController = LevelSelectionViewController()
        levelSelectionViewController.modalPresentationStyle = .fullScreen
        levelSelectionViewController.modalTransitionStyle = .flipHorizontal
        levelSelectionViewController.selectBgDifficulty = DifficultyChoosing(rawValue: sender.tag)!
        self.present(levelSelectionViewController, animated: true, completion: nil)
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
