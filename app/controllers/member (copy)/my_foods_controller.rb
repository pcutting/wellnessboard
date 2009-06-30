class MyFoodsController  < BaseController
  # GET /my_foods
  # GET /my_foods.xml
  def index
    @my_foods = MyFood.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_foods }
    end
  end

  # GET /my_foods/1
  # GET /my_foods/1.xml
  def show
    @my_food = MyFood.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_food }
    end
  end

  # GET /my_foods/new
  # GET /my_foods/new.xml
  def new
    @my_food = MyFood.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_food }
    end
  end

  # GET /my_foods/1/edit
  def edit
    @my_food = MyFood.find(params[:id])
  end

  # POST /my_foods
  # POST /my_foods.xml
  def create
    @my_food = MyFood.new(params[:my_food])

    respond_to do |format|
      if @my_food.save
        flash[:notice] = 'MyFood was successfully created.'
        format.html { redirect_to(@my_food) }
        format.xml  { render :xml => @my_food, :status => :created, :location => @my_food }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_food.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my_foods/1
  # PUT /my_foods/1.xml
  def update
    @my_food = MyFood.find(params[:id])

    respond_to do |format|
      if @my_food.update_attributes(params[:my_food])
        flash[:notice] = 'MyFood was successfully updated.'
        format.html { redirect_to(@my_food) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_food.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my_foods/1
  # DELETE /my_foods/1.xml
  def destroy
    @my_food = MyFood.find(params[:id])
    @my_food.destroy

    respond_to do |format|
      format.html { redirect_to(my_foods_url) }
      format.xml  { head :ok }
    end
  end
end
