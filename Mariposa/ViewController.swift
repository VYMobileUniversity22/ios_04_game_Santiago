//
//  ViewController.swift
//  Mariposa
//
//  Created by Santiago Falcon on 10/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ptsLbl: UILabel!
    @IBOutlet var screen: UIView!
    @IBOutlet weak var butterflyBtn: UIImageView!
    
    var count = 0
    var lost = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block:{ [self]  tim in
            
            let height = screen.frame.size.height
            let width = screen.frame.size.width
            
            if count == 10{
                    let alertController = UIAlertController(
                        title: "Haz GANADO",
                        message: "¿Quieres repetir?",
                        preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Repetir",
                                                 style: .default)
                { [self]UIAlertAction in
                    setCount()
                }
                    alertController.addAction(okButton)
                    
                    let cancelButton = UIAlertAction(title: "Cancel",
                                                     style: .destructive)
                    {UIAlertAction in tim.invalidate()}
                    alertController.addAction(cancelButton)
                
                    present(alertController, animated: true)
                return
                
            }
            
            if lost == true{
                    let alertController = UIAlertController(
                        title: "Has PERDIDO",
                        message: "¿Quieres repedir?",
                        preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Repetir",
                                                 style: .default)
                { [self]UIAlertAction in
                        setCount()
                        lost = false}
                    alertController.addAction(okButton)
                    let cancelButton = UIAlertAction(title: "Cancel",
                                                     style: .destructive)
                    {UIAlertAction in tim.invalidate()}
                    alertController.addAction(cancelButton)
                
                    present(alertController, animated: true)
                return
            }
            
            let heightButterfly = butterflyBtn.frame.size.height
            let widthButterfly = butterflyBtn.frame.size.width
            // Do any additional setup after loading the view.
            
            self.butterflyBtn.frame = CGRect(x: rndNumber(maxValue: Int(width) ),
                                             y: rndNumber(maxValue:Int(height) ),
                                             width: Int(widthButterfly),
                                             height: Int(heightButterfly))
            
            let tapButterfly = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
            let tapScreen = UITapGestureRecognizer(target: self, action: #selector(self.tappedScreen(_:)))
            
            tapScreen.numberOfTapsRequired = 2
            self.screen.addGestureRecognizer(tapScreen)
            
            self.butterflyBtn.isUserInteractionEnabled = true
            tapButterfly.numberOfTapsRequired = 2
            self.butterflyBtn.addGestureRecognizer(tapButterfly)
            
        })
        
    }
    
    @objc func tappedScreen(_ sender: UITapGestureRecognizer){
        lost = true
        }
        
    @objc func tapped(_ sender: UITapGestureRecognizer){
        count =  count + 1
        ptsLbl.text = String(count)
    }
    
    func rndNumber(maxValue:Int)-> Int{
        let rnd = Int.random(in:1...maxValue)
        return rnd
    }
    
    func setCount() {
        count = 0
        ptsLbl.text = String(count)
    }
}


