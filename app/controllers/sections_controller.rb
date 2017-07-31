# frozen_string_literal: true
class SectionsController < ApplicationController
  before_action :set_article
  before_action :article_author?, only: %i(new edit update destroy)
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /sections
  # GET /sections.json
  def index
    @sections = @article.sections.all
  end

  # GET /sections/1
  # GET /sections/1.json
  def show; end

  # GET /sections/new
  def new
    @section = @article.sections.new
  end

  # GET /sections/1/edit
  def edit; end

  # POST /sections
  # POST /sections.json
  def create
    @section = @article.sections.build(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to article_sections_path(@section.article), notice: 'Section was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    @section = @article.sections.find(params[:id])
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to article_sections_path(@section.article), notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to article_sections_url(@article), notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_section
    @section = @article.sections.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def section_params
    params.require(:section).permit(:article_id, :title, :content)
  end
end
