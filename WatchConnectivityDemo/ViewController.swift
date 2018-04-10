//
//  ViewController.swift
//  WatchConnectivityDemo
//
//  Created by Neil Hiddink on 4/10/18.
//  Copyright © 2018 Neil Hiddink. All rights reserved.
//

import UIKit
import WatchConnectivity

// MARK: ViewController: UIViewController

class ViewController: UIViewController, WCSessionDelegate {
    
    // MARK: Properties
    
    let session: WCSession!
    
    // MARK: IB Outlets
    
    @IBOutlet var buttons: [UIButton]!
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        self.session = WCSession.default
        super.init(coder: aDecoder)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            session.delegate = self
            session.activate()
        }
    }

    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        print(message.description)
        
        if let nameString = message["buttonName"] as! String? {
            var index = 0
            switch nameString {
                case "Hearts":
                   index = 0
                case "Spades":
                    index = 1
                case "Clubs":
                    index = 2
                case "Diamonds":
                    index = 3
                default:
                    break
            }
            let tappedButton = buttons[index]
            let oldTitle = tappedButton.title(for: .normal)
            
            DispatchQueue.main.async {
                tappedButton.setTitle(nameString, for: .normal)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                tappedButton.setTitle(oldTitle, for: .normal)
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        guard activationState == .activated else {
            print("WCSession is not activated.")
            return
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    // MARK: IB Actions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let i = buttons.index(of: sender) {
            let messageDict = ["buttonName" : i]
            
            session.sendMessage(messageDict, replyHandler: { (content: [String : Any]) -> Void in
                print("Our counterpart sent something back. This is optional.")
            }) { (error) -> Void in
                print("We got an error from our watch device: \(error.localizedDescription)")
            }
        }
    }

}

