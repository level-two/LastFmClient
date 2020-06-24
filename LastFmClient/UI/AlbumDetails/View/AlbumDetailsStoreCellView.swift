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

class AlbumDetailsStoreCellView: UICollectionViewCell, NibLoadable, TypeIdentifiable {
    @IBOutlet private weak var button: UIButton?

    override func prepareForReuse() {
        super.prepareForReuse()
        clearBindings()
    }

    func configure(with viewModel: AlbumStoreViewModel) {
        self.viewModel = viewModel
        setupBindings()
    }

    func style(with theme: Theme?) {
        self.theme = theme
        theme?.apply(style: .lightDarkBackground, to: self.contentView)
    }

    private var viewModel: AlbumStoreViewModel?
    private var theme: Theme?
    private var disposeBag = DisposeBag()
}

private extension AlbumDetailsStoreCellView {
    func setupBindings() {
        clearBindings()

        guard let viewModel = viewModel else { return }

        viewModel.stored.bind { [weak self] isStored in
            self?.theme?.apply(style: isStored ? .removeButton : .addButton, to: self?.button)
            self?.button?.setTitle(isStored ? "Remove" : "Add", for: .normal)
        }.disposed(by: disposeBag)

        button?.rx.tap
            .bind(to: viewModel.store)
            .disposed(by: disposeBag)
    }

    func clearBindings() {
        disposeBag = DisposeBag()
    }
}
