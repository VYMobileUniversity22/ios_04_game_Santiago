//
//  ViewController.swift
//  Mariposa
//
//  Created by Santiago Falcon on 10/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var ptsLbl: UILabel!
    @IBOutlet var screen: UIView!
    @IBOutlet var butterflyBtn: UIImageView!

    var count = 0
    var lost = false

    override func viewDidLoad() {
        super.viewDidLoad()
        game()
    }

    // Craete game
    func game() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { tim in
            
            let heightButterfly = self.butterflyBtn.frame.size.height
            let widthButterfly = self.butterflyBtn.frame.size.width

            let height = (self.screen.frame.size.height) - heightButterfly
            let width = (self.screen.frame.size.width) - widthButterfly

            self.butterflyBtn.frame = CGRect(x: self.rndNumber(maxValue: Int(width)),
                                             y: self.rndNumber(maxValue: Int(height)),
                                             width: Int(widthButterfly),
                                             height: Int(heightButterfly))

            self.winnerLoser(tim: tim)
            self.taps()
            
        })
    }

    // Func when tap screen
    @objc func tappedScreen(_ sender: UITapGestureRecognizer) {
        lost = true
    }

    // Func when tap image
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        count += 1
        ptsLbl.text = String(count)
    }

    // Create random number
    func rndNumber(maxValue: Int) -> Int {
        let rnd = Int.random(in: 1 ... maxValue)
        return rnd
    }

    // Set count to 0
    func setCount() {
        count = 0
        ptsLbl.text = String(count)
    }

    // Alert View with params
    func alertView(title: String,
                   message: String,
                   titleOk: String,
                   titleCancel: String,
                   lost: Bool,
                   tim: Timer) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okButton = UIAlertAction(title: titleOk,
                                     style: .default) { _ in
            self.setCount()
            self.lost = lost
        }
        alertController.addAction(okButton)
        let cancelButton = UIAlertAction(title: titleCancel,
                                         style: .destructive) { _ in tim.invalidate()
                self.lost = false
            }
        alertController.addAction(cancelButton)

        present(alertController, animated: true)
    }
    
    func taps(){
        let tapButterfly = UITapGestureRecognizer(target: self,
                                                  action: #selector(self.tapped(_:)))
        let tapScreen = UITapGestureRecognizer(target: self,
                                               action: #selector(self.tappedScreen(_:)))

        tapScreen.numberOfTapsRequired = 2
        self.screen.addGestureRecognizer(tapScreen)

        self.butterflyBtn.isUserInteractionEnabled = true
        tapButterfly.numberOfTapsRequired = 2
        self.butterflyBtn.addGestureRecognizer(tapButterfly)
    }
    
    func winnerLoser(tim: Timer){
        // When you WIN
        if self.count == 10 {
            self.alertView(title: "Has Ganado",
                           message: "Quieres Repetir",
                           titleOk: "Repetir",
                           titleCancel: "Cancel",
                           lost: false,
                           tim: tim)
            return
        }
        // When you LOSE
        if self.lost == true {
            self.alertView(title: "Has Perdido",
                           message: "¿Quieres Repetir?",
                           titleOk: "Repetir",
                           titleCancel: "Cancel",
                           lost: false,
                           tim: tim)
            return
        }
    }
}
