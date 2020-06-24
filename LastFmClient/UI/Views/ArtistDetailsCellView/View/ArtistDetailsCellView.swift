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
import RxCocoa

final class ArtistDetailsCellView: UICollectionViewCell, NibLoadable {
    @IBOutlet private var artistPhoto: UIImageView?
    @IBOutlet private var name: UILabel?
    @IBOutlet private var shortDescription: UILabel?
    @IBOutlet private var hudView: UIView?

    override func prepareForReuse() {
        super.prepareForReuse()
        cleanBindings()
    }

    func configure(with viewModel: ArtistDetailsCellViewModel) {
        self.viewModel = viewModel
        setupView()
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: name)
        theme.apply(style: .normal, to: shortDescription)
        theme.apply(style: .lightDarkBackground, to: self)
    }

    private var viewModel: ArtistDetailsCellViewModel?
    private var disposeBag = DisposeBag()
}

private extension ArtistDetailsCellView {
    func setupView() {
        cleanBindings()

        name?.text = viewModel?.name
        shortDescription?.text = viewModel?.shortDescription

        setupBindings()
    }

    func setupBindings() {
        guard let viewModel = viewModel,
            let hudView = hudView,
            let artistPhoto = artistPhoto
        else { return }

        viewModel.artistPhoto
            .bind(to: artistPhoto.rx.image)
            .disposed(by: disposeBag)

        viewModel.showLoadingHud
            .map { !$0 }
            .bind(to: hudView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func cleanBindings() {
        disposeBag = DisposeBag()
    }
}
