//
//  InterfaceController.swift
//  WatchConnectivityDemo WatchKit Extension
//
//  Created by Neil Hiddink on 4/10/18.
//  Copyright © 2018 Neil Hiddink. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

// MARK: InterfaceController: WKInterfaceController

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    // MARK: Properties
    let session: WCSession!
    
    // MARK: IB Outlets
    
    @IBOutlet weak var statusLabel: WKInterfaceLabel!
    
    // MARK: Life Cycle
    
    override init() {
        if(WCSession.isSupported()) {
            session =  WCSession.default
        } else {
            session = nil
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    override func willActivate() {
        super.willActivate()
        if (WCSession.isSupported()) {
            session.delegate = self
            session.activate()
        }
        self.statusLabel.setText("")
    }
    
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        guard activationState == .activated else {
            print("WCSession is not activated.")
            return
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("Message from iPhone")
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
            let labelString = ["Hearts", "Spades", "Clubs", "Diamonds"][index]
            
            DispatchQueue.main.async {
                self.statusLabel.setText(labelString)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("setlabel")
                self.statusLabel.setText("")
            }
            
        }
    }
    
    // MARK: Helper Methods
    
    func buttonPressed(name: String) {
        if (WCSession.isSupported()) {
            
            let messageDict = ["buttonName": name]
            session.sendMessage(messageDict, replyHandler: { (content: [String: Any]) -> Void in
                print("Our counterpart sent something back. This is optional")
            }, errorHandler: { (error) -> Void in
                print("We got an error from our paired device : \(error.localizedDescription)")
            })
        }
    }
    
    // MARK: IB Actions
    
    @IBAction func heartsButtonPressed() {
        buttonPressed(name: "Hearts")
    }
    
    @IBAction func spadesButtonPressed() {
        buttonPressed(name: "Spades")
    }
    
    @IBAction func clubsButtonPressed() {
        buttonPressed(name: "Clubs")
    }
    
    @IBAction func diamondsButtonPressed() {
        buttonPressed(name: "Diamonds")
    }
    
}
