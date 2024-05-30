//
//  ImagePicker.swift
//  Ecommerce
//
//  Created by Faizan Mahmood on 07/10/2022.
//

import UIKit
import AVFoundation
import Photos

protocol ImagePickerDelegate: NSObjectProtocol {
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage)
    func cancelButtonDidClick(on imageView: ImagePicker)
}

class ImagePicker: NSObject {

    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate?

    func showImagePickerSheet(on viewController: UIViewController) {
        let alertController = UIAlertController.init(title: nil,
                                                     message: nil,
                                                     preferredStyle: UIDevice.current.userInterfaceIdiom == .phone ?
                                                        .actionSheet :
                                                            .alert)
        let alertActionCamera = UIAlertAction.init(title: "Camera",
                                                   style: UIAlertAction.Style.default) { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            self.present(parent: viewController, sourceType: .camera)
        }
        let alertActionGallery = UIAlertAction.init(title: "Gallery",
                                                    style: UIAlertAction.Style.default) { _ in
            self.present(parent: viewController, sourceType: .photoLibrary)
        }
        let alertActionCancel = UIAlertAction.init(title: "Cancel",
                                                   style: UIAlertAction.Style.cancel,
                                                   handler: nil)
        alertController.addAction(alertActionCamera)
        alertController.addAction(alertActionGallery)
        alertController.addAction(alertActionCancel)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension ImagePicker {

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        controller?.dismiss(animated: animated, completion: completion)
    }

    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType = .photoLibrary) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: UINavigationControllerDelegate
extension ImagePicker: UINavigationControllerDelegate { }

// MARK: UIImagePickerControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
            return
        }

        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
        } else {
            print("Other source")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}
