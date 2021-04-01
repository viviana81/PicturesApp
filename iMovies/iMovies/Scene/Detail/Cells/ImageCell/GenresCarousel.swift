//
//  GenresCarousel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 28/02/21.
//

import UIKit
import Anchorage

class GenresCarousel: UIView {
    
    var onTap: ((Genre) -> Void)?
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    var genres: [Genre] = [] {
        didSet {
            configureButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureConstraints()
    }
    
    func configureUI() {
        backgroundColor = .clear
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func configureConstraints() {
        scrollView.edgeAnchors == edgeAnchors
        stackView.edgeAnchors == scrollView.edgeAnchors
    }
    
    func configureButtons() {
        
        for (index, genre) in genres.enumerated() {
            
            let button = UIButton()
            button.setTitle(genre.name, for: .normal)
            button.setImage(UIImage(named: "arrow-right"), for: .normal)
            button.tintColor = .black
            button.semanticContentAttribute = .forceRightToLeft
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.heightAnchor == 24
            button.tag = index
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            button.setInsets(forContentPadding: .init(top: 4, left: 8, bottom: 4, right: 8), imageTitlePadding: -2)
            stackView.addArrangedSubview(button)
           
            button.addTarget(self, action: #selector(openDetail(_:)), for: .touchUpInside)
        }
        
    }
    
    @objc
    func openDetail(_ sender: UIButton) {
        let genre = genres[sender.tag]
        onTap?(genre)
    }
}
