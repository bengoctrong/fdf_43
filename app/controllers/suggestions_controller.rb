class SuggestionsController < ApplicationController
  before_action :logged_in_user, except: :edit
  before_action :load_suggestion, only: %i(show update destroy)

  def new
    @suggestion = current_user.suggestions.build
  end

  def create
    @suggestion = current_user.suggestions.build suggestion_params
    if @suggestion.save
      flash[:success] = t "suggestions.create_success"
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def index
    @suggestions = Suggestion.paginate(page: params[:page],
    per_page: Settings.per_page_value).newest
  end

  def update
    @suggestion.rejected!
    flash[:success] = t "suggestions.reject_success"
    redirect_to @suggestion
  end

  def destroy
    if @suggestion.rejected? || @suggestion.accepted?
      @suggestion.destroy
      flash[:success] = t "suggestions.destroy_success"
      redirect_to suggestions_path
    else
      flash[:info] = t "suggestions.destroy_fails"
      redirect_to @suggestion
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit :product_name, :description, :price,
      :product_type
  end

  def load_suggestion
    @suggestion = Suggestion.find_by id: params[:id]
    return if @suggestion
    flash[:danger] = t "suggestions.not_found_suggestion"
    redirect_to root_path
  end
end
