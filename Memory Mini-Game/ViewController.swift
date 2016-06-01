//
//  ViewController.swift
//  Memory Mini-Game
//
//  Created by Pawan on 2016-05-15.
//  Copyright © 2016 Pawan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var soundButton: [UIButton]!

    
    var player1: AVAudioPlayer!
    var player2: AVAudioPlayer!
    var player3: AVAudioPlayer!
    var player4: AVAudioPlayer!
    
    var playList = [Int]()
    var currentItem = 0
    var numberOfTaps = 0
    var readyForUser = false
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAudioFiles()
      
    }
    
    func setUpAudioFiles () {
        
        let soundFilePath = NSBundle.mainBundle().pathForResource("1", ofType: "wav")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath!)
        
        let soundFilePath2 = NSBundle.mainBundle().pathForResource("2", ofType: "wav")
        let soundFileURL2 = NSURL(fileURLWithPath: soundFilePath2!)
        
        let soundFilePath3 = NSBundle.mainBundle().pathForResource("3", ofType: "wav")
        let soundFileURL3 = NSURL(fileURLWithPath: soundFilePath3!)
        
        let soundFilePath4 = NSBundle.mainBundle().pathForResource("4", ofType: "wav")
        let soundFileURL4 = NSURL(fileURLWithPath: soundFilePath4!)
        
        
        do {
            try player1 = AVAudioPlayer(contentsOfURL: soundFileURL)
            try player2 = AVAudioPlayer(contentsOfURL: soundFileURL2)
            try player3 = AVAudioPlayer(contentsOfURL: soundFileURL3)
            try player4 = AVAudioPlayer(contentsOfURL: soundFileURL4)
            
        } catch {
            print(error)
        }
        
        player1.delegate = self
        player2.delegate = self
        player3.delegate = self
        player4.delegate = self
        
        player1.numberOfLoops = 0
        player2.numberOfLoops = 0
        player3.numberOfLoops = 0
        player4.numberOfLoops = 0
   
    }

    @IBAction func soundButtonPressed(sender: AnyObject) {
        
        if readyForUser {
            let button = sender as! UIButton
            
            switch button.tag{
                
            case 1:
                player1.play()
                checkIfCorrent(1)
                break
            case 2:
                player2.play()
                checkIfCorrent(2)
                break
            case 3:
                player3.play()
                checkIfCorrent(3)
                break
            case 4:
                player4.play()
                checkIfCorrent(4)
                break
            default:
                break
                
            }
        }
        
    }
    @IBAction func playGame(sender: AnyObject) {
        scoreLabel.text = "Level 1"
        disableButtons()
        let randomNumber = Int(arc4random_uniform(4) + 1)
        playList.append(randomNumber)
        startButton.hidden = true
        playNextItem()
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if currentItem <= playList.count - 1 {
            playNextItem()
            
        }else{
            readyForUser = true
            resetButtonHighlights()
            enableButtons()
        }
    }
    
    func playNextItem () {
        let selectedItem = playList[currentItem]
        
        switch  selectedItem {
        case 1:
            highlightButtonWithTag(1)
            player1.play()
            break
        case 2:
            highlightButtonWithTag(2)
            player2.play()
            break
        case 3:
            highlightButtonWithTag(3)
            player3.play()
            break
        case 4:
            highlightButtonWithTag(4)
            player4.play()
            break
        default:
            break
        }
        currentItem += 1
    }
    func highlightButtonWithTag (tag:Int) {
        switch tag {
        case 1:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"redPressed"), forState: .Normal)
        case 2:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"yellowPressed"), forState: .Normal)
        case 3:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"bluePressed"), forState: .Normal)
        case 4:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"greenPressed"), forState: .Normal)
        default:
            break
        }
    }
    func resetButtonHighlights () {
        soundButton[0].setImage(UIImage(named: "red"), forState: .Normal)
        soundButton[1].setImage(UIImage(named: "yellow"), forState: .Normal)
        soundButton[2].setImage(UIImage(named: "blue"), forState: .Normal)
        soundButton[3].setImage(UIImage(named: "green"), forState: .Normal)
    }
    
    func checkIfCorrent (buttonPressed:Int) {
        
        if buttonPressed == playList[numberOfTaps] {
            if numberOfTaps == playList.count - 1 {
                
                let timer = dispatch_time(dispatch_time_t (DISPATCH_TIME_NOW), Int64(NSEC_PER_SEC))
                
                dispatch_after(timer, dispatch_get_main_queue(), { 
                    
                    self.nextRound()
                })
                return
            }
            numberOfTaps += 1
        }else{
            resetGame()
        }
    }
    
    func resetGame () {
        level = 1
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        playList = []
       
        startButton.hidden = false
        disableButtons()
    }
    
    func nextRound() {
        level += 1
        scoreLabel.text = "Level \(level) "
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        disableButtons()
        let randomNumber = Int(arc4random_uniform(4) + 1 )
        playList.append(randomNumber)
        
        playNextItem()
       
    }
    
    func disableButtons() {
        for button in soundButton{
            button.userInteractionEnabled = false
        }
    }
    func enableButtons() {
        for button in soundButton{
            button.userInteractionEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

