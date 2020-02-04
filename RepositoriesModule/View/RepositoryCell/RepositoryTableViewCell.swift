//
//  RepositoryTableViewCell.swift
//  RepositoriesModule
//
//  Created by user165891 on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import Utils
import Entities
import Kingfisher


final class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak private var ownerAvatarImageView: UIImageView!
    @IBOutlet weak private var repositoryNameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var numberOfForksLabel: UILabel!
    @IBOutlet weak private var numberOfWatchesLabel: UILabel!
    
    static let identifier = "RepositoryCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        ownerAvatarImageView.makeCircle()
    }
    
    func configure(repository: Repository) {
        ownerAvatarImageView.kf.setImage(with: URL(string: repository.owner.avatarUrl))
        repositoryNameLabel.text = repository.name
        descriptionLabel.text = repository.description
        numberOfWatchesLabel.text = "\(repository.watchersCount)"
        numberOfForksLabel.text = "\(repository.forksCount)"
    }
    
}
