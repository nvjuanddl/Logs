//
//  LogsListInteractor.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation

class LogsListInteractor {
    
    // MARK: - Public properties -
    var logsList: [Log] = []
}

// MARK: - LogsListInteractor interface -
extension LogsListInteractor: LogsListInteractorInterface {
    
    func getLogsList(completion: @escaping (LogsListResult) -> Void) {
        let request: URLRequest!
        do {
            request = try ExternalDataRouter.logsList(EmptyRequest()).asURLRequest()
        } catch {
            request = nil
            completion(.error)
            return
        }

        ExternalDataManager.execute(request: request) { [weak self] (result: ExternalDataResult<BaseResponse<[Log]>>) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                strongSelf.logsList = data.results
                completion(.ok)
            case .failure(let data):
                switch data {
                case .api, .decoding:
                    completion(.error)
                case .networkConnectionLost, .notConnectedToInternet:
                    completion(.connectionProblems)
                }
                strongSelf.logsList = []                
            }
        }
    }
}
