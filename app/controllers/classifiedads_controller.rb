class ClassifiedadsController < ApplicationController
  def index
    @classifiedads = Classifiedad.all 
  end

  def show
    @classifiedad = Classifiedad.find(params[:id])
  end

  def edit
    @classifiedad = Classifiedad.find(params[:id])
  end

  def update
    @classifiedad = Classifiedad.find(params[:id])
    @classifiedad.update(classifedad_params)

    redirect_to classifiedads_path and return
  end

  def destroy
    @classifiedad = Classifiedad.find(params[:id])
    @classifiedad.destroy 

    redirect_to classifiedads_path
  end

  def new
    @classifiedad = Classifiedad.new
  end

  def create

    classifiedad = Classifiedad.create(classifedad_params)
    
    redirect_to classifiedad_path(classifiedad.id)
  end

  private
  def classifedad_params
    params.require(:classifiedad).permit(:title)
  end
end
