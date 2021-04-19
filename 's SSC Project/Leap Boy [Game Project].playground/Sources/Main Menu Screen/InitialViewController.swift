// MARK: - Import section

// Importing a SpriteKit framework
import SpriteKit




// MARK: - Class declaration and implementation

// Creating the main menu
public final class InitialViewController: UIViewController {
    
    // MARK: Declaring properties
    
    // Initial SpriteKit scene
    private let initialSpriteKitView: SKView = {
        let spriteKitView = SKView()
        spriteKitView.backgroundColor = .clear
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false
        return spriteKitView
    }()
    
    // Background image view
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Images/Backgrounds/Main Menu/Main Menu Background.png")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Blur visual effect view
    private let blurVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .dark)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Vibrancy visual effect view
    private let vibrancyVisualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .dark), style: .fill)
        visualEffectView.isUserInteractionEnabled = true
        visualEffectView.clipsToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    // Horizontal stack view
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .red
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        stackView.isUserInteractionEnabled = true
        stackView.clipsToBounds = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Game description label
    private let gameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.text =
"""
Welcome to the Leap Boy game
specially created for WWDC21
"""
        label.isUserInteractionEnabled = true
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Play game button
    private lazy var playGameButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Play Game", for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5.0
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    // MARK: Overriding parent methods
    
    // View did load
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSpriteKitView()
        
        self.setupViews()
        
        self.makeLayout()
        
    }
    
    
    
    
    // MARK: Declaring methods
    
    // Setting up SpriteKit view
    private func setupSpriteKitView() {
        let initialScene = InitialScene(size: CGSize(width: 512,
                                                     height: 384))
        self.initialSpriteKitView.presentScene(initialScene)
    }
    
    // Setting up views
    private func setupViews() {
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.view.addSubview(self.backgroundImageView)
        
        self.view.addSubview(self.blurVisualEffectView)
        
        self.blurVisualEffectView.contentView.addSubview(self.vibrancyVisualEffectView)
        
        self.vibrancyVisualEffectView.contentView.addSubview(self.horizontalStackView)
        
    }
    
    // Layout creation
    private func makeLayout() {
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.blurVisualEffectView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.blurVisualEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.blurVisualEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.blurVisualEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.vibrancyVisualEffectView.topAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.topAnchor),
            self.vibrancyVisualEffectView.leadingAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.leadingAnchor),
            self.vibrancyVisualEffectView.trailingAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.trailingAnchor),
            self.vibrancyVisualEffectView.bottomAnchor.constraint(equalTo: self.blurVisualEffectView.contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.horizontalStackView.topAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.topAnchor),
            self.horizontalStackView.leadingAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.leadingAnchor),
            self.horizontalStackView.trailingAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.trailingAnchor),
            self.horizontalStackView.bottomAnchor.constraint(equalTo: self.vibrancyVisualEffectView.contentView.bottomAnchor)
        ])
        
    }
    
}
