//
//  MenuVC.swift
//  PingPong
//
//  Created by David Grau Beltrán  on 25/02/24.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}


class MenuVC : UIViewController {
    
    
    //link main storyboard with MenuVC --> button control+left click and drag here
    @IBAction func Player2(_ sender: Any) {
        moveToGame(game: .player2)
    }
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType){
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        
        self.navigationController?.pushViewController(gameVC, animated: true)
        
        
    }
    
}


