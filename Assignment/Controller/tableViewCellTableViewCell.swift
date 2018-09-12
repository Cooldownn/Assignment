//
//  tableViewCellTableViewCell.swift
//  Assignment
//
//  Created by Macintosh on 11/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit
protocol CellDelegate {
    
    func changeController(title: String)
}

class tableViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button : UIButton!
//    var controllerview : UIViewController!
//    var storyboardID : String!
//    var delegate : CellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func setController(storyboard : String) {
//        
//        storyboardID = storyboard
//    }
//    @IBAction func changeView( _sender: UIButton){
//        delegate?.changeController(title: storyboardID)
//
//
//    }

}
