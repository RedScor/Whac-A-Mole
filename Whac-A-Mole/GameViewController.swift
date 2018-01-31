//
//  GameViewController.swift
//  Whac-A-Mole
//
//  Created by RedScor Yuan on 2018/1/31.
//  Copyright © 2018年 RedScor. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var scoreCallback: ((_ score: Int) -> Void)?

    @IBOutlet var mouseBtns: [UIButton]!
    @IBOutlet weak var scoreLbl: UILabel!
    private var score: Int = 0
    private var counter: Int = 0

    private var gameTimer: Timer?

    private var startbtn: UIButton?

// MARK: - IBOutlet Action
    @IBAction func btnAction(_ sender: UIButton) {

        if sender.isEnabled {
//            print("hit it")
            sender.isEnabled = false
            score += 1
            scoreLbl.text = "Score: \(score)"
        }
    }

    @IBAction func startgame(_ sender: UIButton) {

        counter = 0                     // 重設counter 為0
        setHamsterBtnEnable(false)      // 將所有btn 變為disable 狀態
        setHamsterTimer()               // start timer

        sender.isEnabled = false        // start btn 取消選取
        startbtn = sender               // 紀錄Start btn reference
        score = 0;                      // 分數歸0
        scoreLbl.text = "Score: \(score)"
    }

// MARK: - Lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "遊戲"
        setHamsterBtnEnable(false)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        releaseTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Internel Method
extension GameViewController {

    // 使用enable disable 顯示文字出現與否
    private func setHamsterBtnEnable(_ enable: Bool) {
        for btn in mouseBtns {
            btn.isEnabled = enable
        }
    }

    private func setHamsterTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(GameViewController.hamsterAction),
                                         userInfo: nil,
                                         repeats: true)
    }

    @objc func hamsterAction() {

        setHamsterBtnEnable(false)

        if counter >= 10 {
            releaseTimer()
            self.scoreCallback?(score)
            self.startbtn?.isEnabled = true
            return
        }

        counter += 1
        // set mouse btn text
        let randomNumber = Int(arc4random_uniform(UInt32(mouseBtns.count)))
        let btn: UIButton = self.mouseBtns[randomNumber]
        btn.isEnabled = true
    }

    private func releaseTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
        timeoutAlert()
        setHamsterBtnEnable(false)
    }

    private func timeoutAlert() {

        let alertController = UIAlertController(title: "題示", message: "遊戲時間已到", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "確定", style: .default) { (action) in

        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true) {
        }
    }
    
    /*
     //   隨機產生文字 input: 長度
     func randomString(length: Int) -> String {

     let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
     let len = UInt32(letters.length)

     var randomString = ""

     for _ in 0 ..< length {
     let rand = arc4random_uniform(len)
     var nextChar = letters.character(at: Int(rand))
     randomString += NSString(characters: &nextChar, length: 1) as String
     }
     return randomString
     }
     */
}
