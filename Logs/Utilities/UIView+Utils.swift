//
//  UIView+Utils.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import UIKit

extension UIView {
    
    func showAnimation(_ completion: (() -> Void)?) {
        isUserInteractionEnabled = false
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveLinear
        ) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        } completion: { done in
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                options: .curveLinear
            ) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            } completion: { [weak self] (_) in
                guard let strongSelf = self else { return }
                strongSelf.isUserInteractionEnabled = true
                completion?()
            }
        }
    }
}

