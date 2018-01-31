//
//  ViewController.swift
//  Whac-A-Mole
//
//  Created by RedScor Yuan on 2018/1/31.
//  Copyright © 2018年 RedScor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var preiousScore: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBOutlet Action
    @IBAction func startGame(_ sender: UIButton) {
        pushToGameViewController()
    }

    @IBAction func preScoreAction(_ sender: UIButton) {

        let title = "上回紀錄"
        let content: String = preiousScore > 0 ? "上回紀錄為\(preiousScore)分" : "您尚未有紀錄"
        let cancelStr = "取消"
        let challengeItAgain = "再次挑戰"

        let alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: challengeItAgain, style: .cancel) { (action) in
            self.pushToGameViewController()
        }
        alertController.addAction(doneAction)

        let cancelAction = UIAlertAction(title: cancelStr, style: .default) { (action) in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
        }

    } 
}

// MARK: - Internel Method
extension ViewController {

    private func pushToGameViewController() {  

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameVC = storyboard.instantiateViewController(withIdentifier:"GameVC") as! GameViewController
        navigationController?.pushViewController(gameVC, animated: true)

        //get score from gameVC callback
        gameVC.scoreCallback = { score in
            self.preiousScore = score
        }
    }
}

