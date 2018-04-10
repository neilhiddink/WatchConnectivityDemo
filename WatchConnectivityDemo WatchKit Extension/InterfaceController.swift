//
//  InterfaceController.swift
//  WatchConnectivityDemo WatchKit Extension
//
//  Created by Neil Hiddink on 4/10/18.
//  Copyright © 2018 Neil Hiddink. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    // MARK: Helper Methods
    
    func buttonPressed(name: String) {
        print("Button Pressed: \(name)")
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
