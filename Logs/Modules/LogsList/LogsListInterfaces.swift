//
//  LogsListInterfaces.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation

enum LogsListResult {
    case ok
    case connectionProblems
    case error
}

enum LogsListNavigationOption { }

protocol LogsListWireframeInterface: WireframeInterface { }

protocol LogsListViewInterface: ViewInterface {
    func reloadData()
    func showError(viewModel: ErrorViewModel)
    func hiddenError()
}

protocol LogsListPresenterInterface: PresenterInterface {
    var numberOfItems: Int { get }
    func item(at indexPath: IndexPath) -> LogInfoViewModel
}

protocol LogsListInteractorInterface: InteractorInterface {
    var logsList: [Log] { get }
    func getLogsList(completion: @escaping (LogsListResult) -> Void)
}
