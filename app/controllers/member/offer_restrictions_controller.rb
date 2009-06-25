class Member::OfferRestrictionsController  < Member::BaseController
  # GET /offer_restrictions
  # GET /offer_restrictions.xml
  def index
    @offer_restrictions = OfferRestriction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @offer_restrictions }
    end
  end

  # GET /offer_restrictions/1
  # GET /offer_restrictions/1.xml
  def show
    @offer_restriction = OfferRestriction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @offer_restriction }
    end
  end

  # GET /offer_restrictions/new
  # GET /offer_restrictions/new.xml
  def new
    @offer_restriction = OfferRestriction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @offer_restriction }
    end
  end

  # GET /offer_restrictions/1/edit
  def edit
    @offer_restriction = OfferRestriction.find(params[:id])
  end

  # POST /offer_restrictions
  # POST /offer_restrictions.xml
  def create
    @offer_restriction = OfferRestriction.new(params[:offer_restriction])

    respond_to do |format|
      if @offer_restriction.save
        flash[:notice] = 'OfferRestriction was successfully created.'
        format.html { redirect_to(@offer_restriction) }
        format.xml  { render :xml => @offer_restriction, :status => :created, :location => @offer_restriction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer_restriction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /offer_restrictions/1
  # PUT /offer_restrictions/1.xml
  def update
    @offer_restriction = OfferRestriction.find(params[:id])

    respond_to do |format|
      if @offer_restriction.update_attributes(params[:offer_restriction])
        flash[:notice] = 'OfferRestriction was successfully updated.'
        format.html { redirect_to(@offer_restriction) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer_restriction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_restrictions/1
  # DELETE /offer_restrictions/1.xml
  def destroy
    @offer_restriction = OfferRestriction.find(params[:id])
    @offer_restriction.destroy

    respond_to do |format|
      format.html { redirect_to(offer_restrictions_url) }
      format.xml  { head :ok }
    end
  end
end
