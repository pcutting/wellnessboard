class OfferSkusController < ApplicationController
  # GET /offer_skus
  # GET /offer_skus.xml
  def index
    @offer_skus = OfferSku.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @offer_skus }
    end
  end

  # GET /offer_skus/1
  # GET /offer_skus/1.xml
  def show
    @offer_sku = OfferSku.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @offer_sku }
    end
  end

  # GET /offer_skus/new
  # GET /offer_skus/new.xml
  def new
    @offer_sku = OfferSku.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @offer_sku }
    end
  end

  # GET /offer_skus/1/edit
  def edit
    @offer_sku = OfferSku.find(params[:id])
  end

  # POST /offer_skus
  # POST /offer_skus.xml
  def create
    @offer_sku = OfferSku.new(params[:offer_sku])

    respond_to do |format|
      if @offer_sku.save
        flash[:notice] = 'OfferSku was successfully created.'
        format.html { redirect_to(@offer_sku) }
        format.xml  { render :xml => @offer_sku, :status => :created, :location => @offer_sku }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer_sku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /offer_skus/1
  # PUT /offer_skus/1.xml
  def update
    @offer_sku = OfferSku.find(params[:id])

    respond_to do |format|
      if @offer_sku.update_attributes(params[:offer_sku])
        flash[:notice] = 'OfferSku was successfully updated.'
        format.html { redirect_to(@offer_sku) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer_sku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_skus/1
  # DELETE /offer_skus/1.xml
  def destroy
    @offer_sku = OfferSku.find(params[:id])
    @offer_sku.destroy

    respond_to do |format|
      format.html { redirect_to(offer_skus_url) }
      format.xml  { head :ok }
    end
  end
end
