//
//  FileCell.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 09/09/2022.
//

import UIKit

struct FileCellViewModel {
    let fileName: String
    let averageSpeed: String
}

class FileCell: UITableViewCell {
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(for viewModel: FileCellViewModel) {
        fileNameLabel.text = "File name: \(viewModel.fileName)"
        averageSpeedLabel.text = "Average speed: \(viewModel.averageSpeed)"
    }
}
