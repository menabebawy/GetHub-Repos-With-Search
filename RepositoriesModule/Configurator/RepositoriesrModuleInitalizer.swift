//
//  RepositoriesrModuleInitalizer.swift
//  RepositoriesModule
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

final class RepositoriesModuleInitalizer: NSObject {
    @IBOutlet weak private var repositoriesModuleViewController: RepositoriesModuleViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        let configurator = RepositoriesModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: repositoriesModuleViewController)
    }

}
