class FoodsController  < BaseController
  # GET /foods
  # GET /foods.xml
  def index
    @foods = @current_user.foods.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /foods/1
  def show
    @food = @current_user.foods.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /foods/new
  def new
    @food = Food.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /foods/1/edit
  def edit
    @food = @current_user.foods.find(params[:id])
  end

  # POST /foods
  # POST /foods.xml
  def create
    @food = @current_user.foods.new(params[:food])

    respond_to do |format|
      if @food.save
        flash[:notice] = 'Food was successfully created.'
        format.html { redirect_to(foods_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /foods/1
  def update
    @food = @current_user.foods.find(params[:id])

    respond_to do |format|
      if @food.update_attributes(params[:food])
        flash[:notice] = 'Food was successfully updated.'
        format.html { redirect_to(foods_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.xml
  def destroy
    @food = @current_user.foods.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to(foods_url) }
      format.xml  { head :ok }
    end
  end
end
