class PagesController < ApplicationController

  def index
  end

  helper_method :sort_column, :sort_direction
  def tablefilter
    @foods = Food.order(sort_column + " " + sort_direction)#.limit(10)
    
    respond_to do |format|
      format.html
      format.csv { send_data @foods.to_csv, filename: "foods-#{Date.today}.csv" }
    end
  end

  private
  
  def sort_column
    Food.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
