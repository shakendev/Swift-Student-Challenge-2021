import Foundation

enum DifficultyChoosing: Int {
    case easy
    case medium
    case hard
}

enum BgChoosing: Int {
    case bg1
    case bg2
}

public class Model {
    
    static let sharedInstance = Model() //Singleton
    
    //Variables
    var sound = true
    var score = 0
    var highscore = 0
    var totalscore = 0
    
    var level2UnlockValue = 1000
}
