//
//  ViewController.swift
//  CardMatchGame
//
//  Created by OSU App Center on 5/23/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    //declare a variable to store related information when viewDidload
    var cardArrays = [Card]()
    //declare the instance to use the functions for accesing data from cardModel
    var model = cardModel()
    
    var soundPlayer = SoundManager()
    
    var firstCardPathIndex:IndexPath?
    
    var timer:Timer?
    
    var millSec = 50*1000.0
    
    var won = false
    
    override func viewDidAppear(_ animated: Bool) {
        soundPlayer.playSound(effect: .shuffle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        cardArrays = model.getCards()
        
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func timerFired(){
        
        millSec -= 1
        let seconds:Double = millSec/1000.0
        timerLabel.text = String(format: "Time remaining: %.2f", seconds)
        
        if won {
            timer?.invalidate()
            timerLabel.text = String("You won!!!")
            showAlert(title: "Congradulations!", message: "You won!!")
        }
        
        if millSec == 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            showAlert(title: "Time's up!", message: "Sorry! Better luck next time!")
            
        }
        
        
    }
    
    //how many cells to display
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cardArrays.count
    }
    
    //types of cells to display
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for:indexPath)
        return cell
        
    }
    //display what for certain cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cardCell = cell as? CardCollectionViewCell
        cardCell?.config(card: cardArrays[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        let cardOne = cardArrays[indexPath.row]
      
        if cardOne.isFlipped == false {
            cell?.flipUp()
            soundPlayer.playSound(effect: .flip)
        }
        else {
            //cell?.flipDown()
            return}
        
        if firstCardPathIndex == nil {
            firstCardPathIndex = indexPath
            
        }
        else {
            let firstCell = collectionView.cellForItem(at: firstCardPathIndex!) as? CardCollectionViewCell
            let cardTwo = cardArrays[firstCardPathIndex!.row]
            
            if cardOne.imageName == cardTwo.imageName {
                
                cardOne.isMatched = true
                cardTwo.isMatched = true
                checkWon()
                soundPlayer.playSound(effect: .match)
                cell?.remove()
                firstCell?.remove()
                
                
            }
            else {
                soundPlayer.playSound(effect: .notMatch)
                cardOne.isFlipped = false
                cardTwo.isFlipped = false
                cell?.flipDown()
                firstCell?.flipDown()
                
            }
            firstCardPathIndex = nil
        }
        
        
    }

    func checkWon(){
        won = true
        for card in cardArrays{
            if card.isMatched == false {
                won = false
                break
            }
        }
        
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Continue", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

