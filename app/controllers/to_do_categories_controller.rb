class ToDoCategoriesController < ApplicationController
  # GET /to_do_categories
  # GET /to_do_categories.json
  def index
    @to_do_categories = ToDoCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @to_do_categories }
    end
  end

  # GET /to_do_categories/1
  # GET /to_do_categories/1.json
  def show
    @to_do_category = ToDoCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @to_do_category }
    end
  end

  # GET /to_do_categories/new
  # GET /to_do_categories/new.json
  def new
    @to_do_category = ToDoCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @to_do_category }
    end
  end

  # GET /to_do_categories/1/edit
  def edit
    @to_do_category = ToDoCategory.find(params[:id])
  end

  # POST /to_do_categories
  # POST /to_do_categories.json
  def create
    @to_do_category = ToDoCategory.new(params[:to_do_category])

    respond_to do |format|
      if @to_do_category.save
        format.html { redirect_to @to_do_category, notice: 'To do category was successfully created.' }
        format.json { render json: @to_do_category, status: :created, location: @to_do_category }
      else
        format.html { render action: "new" }
        format.json { render json: @to_do_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /to_do_categories/1
  # PUT /to_do_categories/1.json
  def update
    @to_do_category = ToDoCategory.find(params[:id])

    respond_to do |format|
      if @to_do_category.update_attributes(params[:to_do_category])
        format.html { redirect_to @to_do_category, notice: 'To do category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @to_do_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /to_do_categories/1
  # DELETE /to_do_categories/1.json
  def destroy
    @to_do_category = ToDoCategory.find(params[:id])
    @to_do_category.destroy

    respond_to do |format|
      format.html { redirect_to to_do_categories_url }
      format.json { head :no_content }
    end
  end
end
