// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

import UIKit
import RxSwift
import RxRelay

final class AlbumDetailsViewController: UIViewController, StoryboardLoadable {
    @IBOutlet private var collectionView: UICollectionView?

    private typealias DataSource = UICollectionViewDiffableDataSource<AlbumDetailsViewSection, UUID>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<AlbumDetailsViewSection, UUID>

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupDependencies(viewModel: AlbumDetailsViewModel, theme: Theme) {
        self.viewModel = viewModel
        self.theme = theme
    }

    private let disposeBag = DisposeBag()
    private var dataSource: DataSource?
    private var theme: Theme?
    private var viewModel: AlbumDetailsViewModel?
}

private extension AlbumDetailsViewController {
    func setupView() {
        styleView()
        setupBindings()
        setupCollectionView()
    }

    func styleView() {
        theme?.apply(style: .background, to: collectionView)
        theme?.apply(style: .normal, to: navigationController?.navigationBar)
        theme?.apply(style: .background, to: self.view)
    }

    func setupBindings() {
        viewModel?.showNetworkError.bind { [weak self] interactor in
            self?.showNetworkErrorOverlay(interactor: interactor, theme: self?.theme)
        }.disposed(by: disposeBag)

        viewModel?.showHud
            .bind { [weak self] show in self?.view.showHud(show, theme: self?.theme) }
            .disposed(by: disposeBag)
    }
}

private extension AlbumDetailsViewController {
    func setupCollectionView() {
        registerReusableCells()
        setupLayout()
        setupDataSource()
        bindDataSource()
    }

    func registerReusableCells() {
        collectionView?.registerReusableCell(AlbumDetailsAlbumCellView.self)
        collectionView?.registerReusableCell(AlbumDetailsTrackCellView.self)
        collectionView?.registerReusableCell(AlbumDetailsStoreCellView.self)
    }

    func setupLayout() {
        collectionView?.collectionViewLayout =
            UICollectionViewCompositionalLayout(section: .fullScreenWideAutosized)
    }

    func setupDataSource() {
        guard let collectionView = collectionView else { return }

        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            guard let section = AlbumDetailsViewSection(rawValue: indexPath.section) else {
                fatalError("Undefined section")
            }

            guard let albumDetails = self?.viewModel?.albumDetails,
                let tracks = self?.viewModel?.tracks,
                let albumStore = self?.viewModel?.albumStore
                else { return nil }

            switch section {
            case .albumDetails:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsAlbumCellView.self, for: indexPath)
                cell.configure(with: albumDetails)
                cell.style(with: self?.theme)
                return cell
            case .tracks:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsTrackCellView.self, for: indexPath)
                cell.configure(with: tracks[indexPath.item])
                cell.style(with: self?.theme)
                return cell
            case .albumStore:
                let cell = collectionView.dequeueReusableCell(AlbumDetailsStoreCellView.self, for: indexPath)
                cell.configure(with: albumStore)
                cell.style(with: self?.theme)
                return cell
            }
        }
    }

    func bindDataSource() {
        viewModel?.contentIsReady
            .filter { $0 }
            .bind { [weak self] _ in
                var snapshot = Snapshot()

                snapshot.appendSections([.albumDetails])
                snapshot.appendItems([UUID()], toSection: .albumDetails)

                if let tracks = self?.viewModel?.tracks {
                    snapshot.appendSections([.tracks])
                    snapshot.appendItems(tracks.map { _ in UUID() }, toSection: .tracks)
                }

                snapshot.appendSections([.albumStore])
                snapshot.appendItems([UUID()], toSection: .albumStore)
                self?.dataSource?.apply(snapshot, animatingDifferences: true)
            }.disposed(by: disposeBag)
    }
}
