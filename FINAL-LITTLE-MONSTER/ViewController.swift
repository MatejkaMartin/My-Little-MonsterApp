//
//  ViewController.swift
//  FINAL-LITTLE-MONSTER
//
//  Created by Martin Matějka on 28.06.16.
//  Copyright © 2016 Martin Matějka. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penallty1Img: UIImageView!
    @IBOutlet weak var penallty2Img: UIImageView!
    @IBOutlet weak var penallty3Img: UIImageView!
    @IBOutlet weak var mainMenuBtn: UIButton!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: Timer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDead: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penallty1Img.alpha = DIM_ALPHA
        penallty2Img.alpha = DIM_ALPHA
        penallty3Img.alpha = DIM_ALPHA
        
      //      NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
      NotificationCenter.default.addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: NSNotification.Name(rawValue: "onTargetDropped"), object: nil)
        
        
        do {
            let resourcePath = Bundle.main.path(forResource: "cave-music", ofType: "mp3")!
            let url = URL(fileURLWithPath: resourcePath)
            try musicPlayer = AVAudioPlayer(contentsOf: url)
            
            try sfxBite = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "heart", ofType: "wav")!))
            try sfxDead = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxDead.prepareToPlay()
            sfxHeart.prepareToPlay()
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        startTimer()
    }
    func itemDroppedOnCharacter(_ notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.isUserInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.isUserInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    func changeGameState() {
        
        if !monsterHappy {
            penalties += 1
            
            sfxSkull.play()
            if penalties == 1 {
                penallty1Img.alpha = OPAQUE
                penallty2Img.alpha = DIM_ALPHA
                
            } else if penalties == 2{
                penallty2Img.alpha = OPAQUE
                penallty3Img.alpha = DIM_ALPHA
                
            } else if penalties == 3 {
                penallty3Img.alpha = OPAQUE
            } else {
                penallty1Img.alpha = DIM_ALPHA
                penallty2Img.alpha = DIM_ALPHA
                penallty3Img.alpha = DIM_ALPHA
            }
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
            
        }
        let rand = arc4random_uniform(2) // 0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.isUserInteractionEnabled = false
            heartImg.alpha = OPAQUE
            heartImg.isUserInteractionEnabled = true
            
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.isUserInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.isUserInteractionEnabled = true
        }
        currentItem = rand
        monsterHappy = false
       
        
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDead.play()
        mainMenuBtn.isHidden = false
        musicPlayer.stop()
        foodImg.isHidden = true
        heartImg.isHidden = true
    
        
        }
    
    func newGame() {
        viewDidLoad()
        mainMenuBtn.isHidden = true
        monsterImg.playIdleAnimation()
        penalties = 0
        foodImg.isHidden = false
        heartImg.isHidden = false
        
    }
    

}

 
