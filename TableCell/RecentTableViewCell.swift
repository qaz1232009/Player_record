//
//  RecentTableViewCell.swift
//  Player_record
//
//  Created by ddcfv on 2020/4/21.
//  Copyright © 2020 ddcfv. All rights reserved.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
    @IBOutlet var music_name_Label: UILabel! {
        didSet {
            music_name_Label.numberOfLines = 0
        }
    }
    @IBOutlet var level_Label: UILabel! {
        didSet {
            level_Label.numberOfLines = 0
        }
    }
    @IBOutlet var rank_Label: UILabel! {
        didSet {
            rank_Label.numberOfLines = 0
        }
    }
    @IBOutlet var score_Label: UILabel! {
        didSet {
            score_Label.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
