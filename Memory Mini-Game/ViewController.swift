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
    @IBOutlet weak var scoreLabel: UILabel! // Level Label
    @IBOutlet weak var startButton: UIButton! //Start Game Button
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
        // Do any additional setup after loading the view, typically from a nib.
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
        
        let button = sender as! UIButton
        
        switch button.tag{
            
        case 1:
            player1.play()
            break
        case 2:
            player2.play()
            break
        case 3:
            player3.play()
            break
        case 4:
            player4.play()
            break
        default:
            break
            
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

