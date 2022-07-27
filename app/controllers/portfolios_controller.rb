# frozen_string_literal: true

class PortfoliosController < ApplicationController
  def index
    @portfolio_items = Portfolio.all
  end

  def angular
    @angular_portfolio_items = Portfolio.angular
  end

  def new
    @portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
  end

  def create
    @portfolio_item =
      Portfolio.new(
        params.require(:portfolio).permit(
          :title,
          :subtitle,
          :body,
          technologies_attributes: [:name]
        )
      )
    respond_to do |format|
      if @portfolio_item.save
        format.html do
          redirect_to portfolios_path,
                      notice: "Your portfolio item is now live."
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @portfolio_item = Portfolio.find(params[:id])
  end

  def update
    @portfolio_item = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio_item.update(
           params.require(:portfolio).permit(:title, :subtitle, :body)
         )
        format.html do
          redirect_to portfolios_path,
                      notice: "The record successfully updated."
        end
      else
        format.html { render :edit }
      end
    end
  end

  def show
    @portfolio_item = Portfolio.find(params[:id])
  end

  def destroy
    # Perform the lookup
    @portfolio_item = Portfolio.find(params[:id])
    # Destroy/delete the record
    @portfolio_item.destroy
    # Redirect
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: "Record was removed!" }
    end
  end

  # This is a dummy-class that is reusable through the code
  def persist
    @_params
  end
end
