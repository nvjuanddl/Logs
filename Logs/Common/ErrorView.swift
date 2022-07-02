//
//  ErrorView.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import UIKit

struct ErrorViewModel {
    let actionCallback: (() -> Void)?
    let imageName: String
    let title: String
    let titleAction: String
}

class ErrorView: UIView {
    
    // MARK: - Private properties -
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.titleLabel?.textColor = .red
        button.addTarget(self, action: #selector(didPressOnAction), for: .touchUpInside)
        return button
    }()
    
    private var actionCallback: (() -> Void)?
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setUpConstraints()
        backgroundColor = UIColor.gray
        layer.cornerRadius = 9
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action -
    @objc private func didPressOnAction() {
        actionButton.showAnimation(actionCallback)
    }
    
    // MARK: - Private methods -
    private func addViews() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(imageViewContainer)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(actionButton)
        imageViewContainer.addSubview(imageView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
                        
            NSLayoutConstraint(
                item: imageViewContainer,
                attribute: .height,
                relatedBy: .equal,
                toItem: imageViewContainer,
                attribute: .width,
                multiplier: 1,
                constant: 0
            ),
            
            NSLayoutConstraint(
                item: imageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: imageView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            ),
            
            NSLayoutConstraint(
                item: imageView,
                attribute: .height,
                relatedBy: .lessThanOrEqual,
                toItem: imageViewContainer,
                attribute: .height,
                multiplier: 0.5,
                constant: 0
            )
        ])
    }
    
    // MARK: - Public methods -
    func configure(with viewModel: ErrorViewModel) {
        titleLabel.text = viewModel.title
        imageView.image = UIImage(named: viewModel.imageName)
        actionButton.setTitle(viewModel.titleAction, for: .normal)
        actionCallback = viewModel.actionCallback
    }
}
