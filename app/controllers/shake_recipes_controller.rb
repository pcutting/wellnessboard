class ShakeRecipesController  < BaseController
  # GET /shake_recipes
  # GET /shake_recipes.xml
  def index
    @shake_recipes = ShakeRecipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shake_recipes }
    end
  end

  # GET /shake_recipes/1
  # GET /shake_recipes/1.xml
  def show
    @shake_recipe = ShakeRecipe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shake_recipe }
    end
  end

  # GET /shake_recipes/new
  # GET /shake_recipes/new.xml
  def new
    @shake_recipe = ShakeRecipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shake_recipe }
    end
  end

  # GET /shake_recipes/1/edit
  def edit
    @shake_recipe = ShakeRecipe.find(params[:id])
  end

  # POST /shake_recipes
  # POST /shake_recipes.xml
  def create
    @shake_recipe = ShakeRecipe.new(params[:shake_recipe])

    respond_to do |format|
      if @shake_recipe.save
        flash[:notice] = 'ShakeRecipe was successfully created.'
        format.html { redirect_to(@shake_recipe) }
        format.xml  { render :xml => @shake_recipe, :status => :created, :location => @shake_recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shake_recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shake_recipes/1
  # PUT /shake_recipes/1.xml
  def update
    @shake_recipe = ShakeRecipe.find(params[:id])

    respond_to do |format|
      if @shake_recipe.update_attributes(params[:shake_recipe])
        flash[:notice] = 'ShakeRecipe was successfully updated.'
        format.html { redirect_to(@shake_recipe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shake_recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shake_recipes/1
  # DELETE /shake_recipes/1.xml
  def destroy
    @shake_recipe = ShakeRecipe.find(params[:id])
    @shake_recipe.destroy

    respond_to do |format|
      format.html { redirect_to(shake_recipes_url) }
      format.xml  { head :ok }
    end
  end
end
