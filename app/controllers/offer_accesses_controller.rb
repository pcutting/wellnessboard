class OfferAccessesController  < BaseController
  # GET /offer_accesses
  # GET /offer_accesses.xml
  def index
    @offer_accesses = OfferAccess.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @offer_accesses }
    end
  end

  # GET /offer_accesses/1
  # GET /offer_accesses/1.xml
  def show
    @offer_access = OfferAccess.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @offer_access }
    end
  end

  # GET /offer_accesses/new
  # GET /offer_accesses/new.xml
  def new
    @offer_access = OfferAccess.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @offer_access }
    end
  end

  # GET /offer_accesses/1/edit
  def edit
    @offer_access = OfferAccess.find(params[:id])
  end

  # POST /offer_accesses
  # POST /offer_accesses.xml
  def create
    @offer_access = OfferAccess.new(params[:offer_access])

    respond_to do |format|
      if @offer_access.save
        flash[:notice] = 'OfferAccess was successfully created.'
        format.html { redirect_to(@offer_access) }
        format.xml  { render :xml => @offer_access, :status => :created, :location => @offer_access }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer_access.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /offer_accesses/1
  # PUT /offer_accesses/1.xml
  def update
    @offer_access = OfferAccess.find(params[:id])

    respond_to do |format|
      if @offer_access.update_attributes(params[:offer_access])
        flash[:notice] = 'OfferAccess was successfully updated.'
        format.html { redirect_to(@offer_access) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer_access.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_accesses/1
  # DELETE /offer_accesses/1.xml
  def destroy
    @offer_access = OfferAccess.find(params[:id])
    @offer_access.destroy

    respond_to do |format|
      format.html { redirect_to(offer_accesses_url) }
      format.xml  { head :ok }
    end
  end
end
