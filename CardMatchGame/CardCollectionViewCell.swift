//
//  CardCollectionViewCell.swift
//  CardMatchGame
//
//  Created by OSU App Center on 5/23/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cardFrontView: UIImageView!
    
    
    @IBOutlet weak var cardBackView: UIImageView!
    
    var card:Card?
    
    func config(card:Card){
        
        cardFrontView.image = UIImage(named: card.imageName)
        self.card = card
        
        if card.isFlipped == false{
            flipDown(0, 0)
        }
        else{
            flipUp(0)
        }
        
        if card.isMatched == false {
            cardFrontView.alpha = 1
            cardBackView.alpha = 1
        }
        else{
            cardFrontView.alpha = 0
            cardBackView.alpha = 0
        }
        
    }
    
    
    func flipUp(_ time: TimeInterval = 0.5){
        UIView.transition(from: cardBackView, to: cardFrontView, duration: time, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        card?.isFlipped = true
        
    }
    
    func flipDown (_ time: TimeInterval = 0.5, _ delay: TimeInterval = 0.5){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+delay) {
            UIView.transition(from: self.cardFrontView, to: self.cardBackView, duration: time, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion:  nil)
        }
        
        card?.isFlipped = false
    }
    
    func remove(){
        cardBackView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.cardFrontView.alpha = 0
        }, completion: nil)
        
    }
    
}
