class DocumentUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /^[.+]/

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env == 'production'
      "/var/www/mns/current/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    doc_kind = DocumentKind.find(model.document_kind_id)
    current_num_of_docs_by_doc_kind = doc_kind.documents.where(person_id: model.person_id).count
    name_by_rule = [model.person_id, doc_kind.field_name, current_num_of_docs_by_doc_kind].join('_')
    [name_by_rule, file.extension].join('.')
  end
end
