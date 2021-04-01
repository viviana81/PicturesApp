//
//  DetailViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func openGenreDetail(genre: Genre)
    func openKeywordDetail(keyword: Keyword)
}

class DetailViewController: UIViewController {

    // MARK: - Vars
    private let detailVM: DetailViewModel
    
    init(detailVM: DetailViewModel) {
        self.detailVM = detailVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var detailCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.register(ImageCollectionViewCell.self)
        collection.register(ReviewsCollectionViewCell.self)
        collection.register(OverviewCollectionViewCell.self)
        collection.register(KeywordsCollectionViewCell.self)
        collection.register(PeopleCollectionViewCell.self)
        collection.register(CollectionsCollectionViewCell.self)
        collection.register(ImagesCollectionViewCell.self)
        collection.register(HeaderView.self, forSupplementaryViewOfKind: HeaderView.kind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailCollection.pin(to: view)
        detailVM.getFilmDetail()
        detailVM.reloadData = {
            self.detailCollection.reloadData()
        }
    }
    
    // MARK: - Actions
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let sectionLayoutKind = SectionLayout.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .image:
                return CollectionLayout.imageLayout
            case .reviews:
                return CollectionLayout.reviewsLayout
            case .overview, .keywords:
                return CollectionLayout.overviewsLayout
            case .crew, .cast:
                return CollectionLayout.peopleItemLayout
            case .similar, .recomended:
                return CollectionLayout.filmItemLayout
            case .otherImages:
                return CollectionLayout.imagesLayout
                
            }
        }
        
        return layout
    }
}
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionLayout.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        let section = SectionLayout.allCases[section]
        
        switch section {
        case .image, .reviews, .overview, .keywords:
            return 1
        case .cast:
            return detailVM.cast.count
        case .crew:
            return detailVM.crew.count
        case .similar:
            return detailVM.similar.count
        case .recomended:
            return detailVM.recomended.count
        case .otherImages:
            return detailVM.images.count
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = SectionLayout.allCases[indexPath.section]
        switch section {
        case .image:
            let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withFilmVM: detailVM.filmVM)
            
            cell.genresCarousel.onTap = { [weak self] genre in
                self?.delegate?.openGenreDetail(genre: genre)
            }
            return cell
            
        case .reviews:
            let cell: ReviewsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withReviews: detailVM.reviews)
            return cell
        case .overview:
            let cell: OverviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withFilmVM: detailVM.filmVM)
            return cell
        case .keywords:
            let cell: KeywordsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withViewModel: detailVM)
            cell.keywordCarousel.onTap = { [weak self] keyword in
                self?.delegate?.openKeywordDetail(keyword: keyword)
            }
            return cell
            
        case .cast:
            let cell: PeopleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let people = detailVM.cast[indexPath.item]
            cell.configure(withPeopleCast: people)
            return cell
        case .crew:
            let cell: PeopleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let people = detailVM.crew[indexPath.item]
            cell.configure(withPeopleCrew: people)
            return cell
        case .similar:
            let cell: CollectionsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let similar = detailVM.similar[indexPath.item]
            cell.configure(withSimilar: similar)
            return cell
        case .recomended:
            let cell: CollectionsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let recomended = detailVM.recomended[indexPath.item]
            cell.configure(withRecomended: recomended)
            return cell
        case .otherImages:
            let cell: ImagesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let image = detailVM.images[indexPath.item]
            cell.configure(withImage: image)
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else {
            fatalError("Cannot create header view")
        }

        if indexPath.section == 0 {
            supplementaryView.label.text = detailVM.filmVM?.film.title
        } else {
            supplementaryView.label.text = SectionLayout.allCases[indexPath.section].title
            supplementaryView.label.font = .boldSystemFont(ofSize: 16)
            
        }
        
        return supplementaryView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionLayout.allCases[indexPath.section]
       
        switch section {
        
        case .reviews:
            let reviews = detailVM.reviews
            let detail = ReviewsTableViewController(reviewsVM: ReviewsViewModel(reviews: reviews))
            navigationController?.pushViewController(detail, animated: true)
        case .overview:
            print("image")
        case .keywords:
            print("image")
        default:
            break
        }
    }
}
