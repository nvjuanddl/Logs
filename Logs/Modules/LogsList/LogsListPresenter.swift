//
//  LogsListPresenter.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation

class LogsListPresenter {
    
    // MARK: - Private properties -
    private let interactor: LogsListInteractorInterface
    private let wireframe: LogsListWireframeInterface
    private unowned let view: LogsListViewInterface
        
    // MARK: - Lifecycle -
    init(
        wireframe: LogsListWireframeInterface,
        view: LogsListViewInterface,
        interactor: LogsListInteractorInterface
    ) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - Private methods -
    private func getLogsList() {
        interactor.getLogsList { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .ok:
                strongSelf.view.hiddenError()
                strongSelf.view.reloadData()
            case .connectionProblems, .error:
                let actionCallback: (() -> Void) = {
                    guard let strongSelf = self else { return }
                    strongSelf.getLogsList()
                }
                
                let title = result == .connectionProblems ? NSLocalizedString("logsList.noInternetConection", comment: "") : NSLocalizedString("logsList.tryAgainLater", comment: "")
                strongSelf.view.showError(
                    viewModel: ErrorViewModel(
                        actionCallback: actionCallback,
                        imageName: result == .connectionProblems ? "cloud-error" : "server-error",
                        title: title,
                        titleAction: NSLocalizedString("logsList.tryAgain", comment: "")
                    )
                )
            }
        }
    }
}

// MARK: - LogsListPresenter interface -
extension LogsListPresenter: LogsListPresenterInterface {
    
    var numberOfItems: Int { interactor.logsList.count }
    
    func viewDidLoad() {
        getLogsList()
    }
    
    func item(at indexPath: IndexPath) -> LogInfoViewModel {
        return LogInfoViewModel(
            title: interactor.logsList[indexPath.row].name,
            imageURL: URL(string: interactor.logsList[indexPath.row].image)
        )
    }
}
