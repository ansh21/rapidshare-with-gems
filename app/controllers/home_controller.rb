class HomeController < ApplicationController

  def index
    if user_signed_in?
      @document = Document.new
      @earlier_documents = Document.all
    else
      render 'landing'
    end
  end


  def upload
    document = Document.new(document_params)
    document.user = current_user
    if document.save
      flash[:notice] = "File uploaded successfully"
    else
      flash[:danger] = "Some error occured. Please try again."
    end
    redirect_to '/'
  end

  def download
    @document = Document.find_by_id(params[:id])
    if @document && @document.user == current_user
      send_file @document.asset.path
    else
      flash[:warning] = "Invalid Request"
      redirect_to '/'
    end
  end

  def delete
    @document = Document.find_by_id(params[:id])
    if @document && @document.user == current_user
      @document.destroy
    else
      flash[:warning] = "Invalid Request"
    end
    redirect_to '/'
  end

  private

  def document_params
    params.fetch(:document, {}).permit(:asset)
  end
end
