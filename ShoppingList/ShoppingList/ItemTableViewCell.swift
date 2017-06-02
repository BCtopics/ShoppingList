//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Bradley GIlmore on 6/2/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - IBActions
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.cellButtonTapped(sender: self)
    }
    
    var item: Item? {
        didSet{
            updateViews()
        }
    }
    
    var delegate: ItemTableViewCellDelegate?
    
    func updateViews(){
        
        guard let item = item else { return }
        self.titleTextLabel.text = item.name
        
        if item.isComplete == false {
            completeButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        } else {
            completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        }
        
    }

}

protocol ItemTableViewCellDelegate {
    
    func cellButtonTapped(sender: ItemTableViewCell)
    
}
