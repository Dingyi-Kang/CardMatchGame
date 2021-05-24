//
//  cardModel.swift
//  CardMatchGame
//
//  Created by OSU App Center on 5/23/21.
//

import Foundation


class cardModel {
    
    func getCards() -> [Card]{
        var cardArrays = [Card]()
        var array = [Int]()
        
        for _ in 1...8{
            
            var randomNum = Int.random(in: 1...13)
            while array.contains(randomNum){
                randomNum = Int.random(in: 1...13)
            }
            array.append(randomNum)
            
            let cardOne = Card()
            cardOne.imageName = "card\(randomNum)"
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNum)"
            
            cardArrays.append(cardOne)
            cardArrays.append(cardTwo)
            
        }
        
        cardArrays.shuffle()
        return cardArrays
    }
    
    
    
}
