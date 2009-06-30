class QuickSupportsController  < BaseController
  # GET /quick_supports
  # GET /quick_supports.xml
  def index
    @quick_supports = QuickSupport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quick_supports }
    end
  end

  # GET /quick_supports/1
  # GET /quick_supports/1.xml
  def show
    @quick_support = QuickSupport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quick_support }
    end
  end

  # GET /quick_supports/new
  # GET /quick_supports/new.xml
  def new
    @quick_support = QuickSupport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quick_support }
    end
  end

  # GET /quick_supports/1/edit
  def edit
    @quick_support = QuickSupport.find(params[:id])
  end

  # POST /quick_supports
  # POST /quick_supports.xml
  def create
    @quick_support = QuickSupport.new(params[:quick_support])

    respond_to do |format|
      if @quick_support.save
        flash[:notice] = 'QuickSupport was successfully created.'
        format.html { redirect_to(@quick_support) }
        format.xml  { render :xml => @quick_support, :status => :created, :location => @quick_support }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quick_support.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quick_supports/1
  # PUT /quick_supports/1.xml
  def update
    @quick_support = QuickSupport.find(params[:id])

    respond_to do |format|
      if @quick_support.update_attributes(params[:quick_support])
        flash[:notice] = 'QuickSupport was successfully updated.'
        format.html { redirect_to(@quick_support) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quick_support.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quick_supports/1
  # DELETE /quick_supports/1.xml
  def destroy
    @quick_support = QuickSupport.find(params[:id])
    @quick_support.destroy

    respond_to do |format|
      format.html { redirect_to(quick_supports_url) }
      format.xml  { head :ok }
    end
  end
end
