
import UIKit
import SpriteKit
import YYSDK
import AVFoundation

extension SpriteViewController {
    func playMusice(_ filename: String) {
        if let url = Bundle.main.url(forResource: filename, withExtension: nil) {
            if let audioPlayer = try? AVAudioPlayer(contentsOf: url) {
                musicPlayer = audioPlayer
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
            }
        }
    }
}

class SpriteViewController: UIViewController {
    var musicPlayer: AVAudioPlayer!
    
    override func loadView() {
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpriteView()
        playBackgroundMusic()
    }
    
    func setupSpriteView() {
        if let spriteView = view as? SKView {
            /**
             打开诊断信息，这些诊断信息描述了场景是怎样渲染视图的。
             最重要的代码段时帧率显示设置（spriteView.showFPS）。
             任何情况下你都希望游戏按照一个固定的帧率运行。
             其他的代码设置了要显示其他一些信息。
             */
            spriteView.showDiagnosticInfo()
            
            let hello = HelloScene(size: UIScreen.main.bounds.size)
            spriteView.presentScene(hello)
        }
    }
    
    func playBackgroundMusic() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            
        }
        playMusice("BackgroundMusic.mp3")
    }
    
}


































