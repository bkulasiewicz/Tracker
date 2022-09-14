//
//  ViewController.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 08/09/2022.
//

import UIKit

class FilesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private let filesViewModel: FilesFeeder
    
    var fileCellViewModels = [FileCellViewModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                UIView.transition(with: self.tableView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                    self.tableView.reloadData()
                    self.isLoading = false
                })
            }
        }
    }
    
    init?(filesViewModel: FilesFeeder,
          coder: NSCoder) {
        self.filesViewModel = filesViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
    
    func loadData() {
        isLoading = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            switch self.filesViewModel.loadData() {
            case let .success(viewModels):
                self.fileCellViewModels = viewModels
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

extension FilesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fileCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell") as? FileCell else { return UITableViewCell() }
         
        let viewModel = fileCellViewModels[indexPath.row]
        cell.configureView(for: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filesViewModel.select(at: indexPath.row)
    }
}

//MARK: ActivityIndicator Helper
extension FilesViewController {
    private var isLoading: Bool {
        get {
            loadingIndicator.isAnimating
        }
        set {
            if newValue {
                loadingIndicator.startAnimating()
            } else {
                loadingIndicator.stopAnimating()
            }
            loadingIndicator.isHidden = !newValue
        }
    }
}
