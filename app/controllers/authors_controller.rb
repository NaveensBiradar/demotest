class AuthorsController < ApplicationController


  # POST /authors
  def create
    @author = Author.new(author_params)

    if params[:name] && params[:dob] != '' || nil

        if verify_recaptcha(model: @user) && @user.save
            if @author.save
                render json: @author, status: :created, location: @author
            else
                render json: @author.errors, status: :unprocessable_entity
            end
        else
          render ‘new’
        end
    else
      render json: @author.errors, status: :no_content
    end
    
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.fetch(:author, {})
    end
end
