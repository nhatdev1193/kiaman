class Staff::DocumentsController < Staff::BaseController
  before_action :set_person, only: [:upload_documents, :download_document, :show]

  #
  # Upload multiple files
  # POST /staff/people/:person_id/documents
  #
  def upload_documents
    # Do the upload & save the records info
    doc       = Document.new(document_params)
    doc.staff = current_staff
    doc.save!

    # After upload successfully, update the metadata for the uploaded files
    doc.filename     = doc.file.filename
    doc.url          = doc.file.url
    doc.size         = doc.file.size
    doc.physic_path  = doc.file.path
    doc.content_type = doc.file.content_type
    doc.save!

    render json: {
        id: doc.id
    }, status:   :created
  end

  #
  # Download a single file
  # GET /staff/people/:person_id/documents/:id/download
  #
  def download_document
    document = @person.documents.find(params[:id])

    send_file document.physic_path, type: document.content_type
  end

  # Show single file
  def show
    document = @person.documents.find(params[:id])

    send_file document.physic_path, type: document.content_type, disposition: 'inline'
  end


  private

  def set_person
    person_id = params[:id]
    person_id = params[:person_id] if params[:person_id].present?

    @person = Person.find(person_id)
  end

  def document_params
    params.permit(:person_id, :document_kind_id, :file)
  end
end
