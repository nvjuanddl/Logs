//
//  LogsListWireframe.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation

class LogsListWireframe: BaseWireframe {

    // MARK: - Module setup -
    init() {
        let viewController = LogsListViewController()
        super.init(viewController: viewController)
        let interactor = LogsListInteractor()
        let presenter = LogsListPresenter(
            wireframe: self,
            view: viewController,
            interactor: interactor
        )
        viewController.presenter = presenter
    }
}

// MARK: - LogsListWireframe interface -
extension LogsListWireframe: LogsListWireframeInterface {

    func navigate(to option: LogsListNavigationOption) { }
}
