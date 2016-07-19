Econaider::Admin.controllers :business_indices do
  get :index do
    @title = "Business_indices"
    @business_indices = BusinessIndex.all
    render 'business_indices/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'business_index')
    @business_index = BusinessIndex.new
    render 'business_indices/new'
  end

  post :create do
    @business_index = BusinessIndex.new(params[:business_index])
    if @business_index.save
      @title = pat(:create_title, :model => "business_index #{@business_index.id}")
      flash[:success] = pat(:create_success, :model => 'BusinessIndex')
      params[:save_and_continue] ? redirect(url(:business_indices, :index)) : redirect(url(:business_indices, :edit, :id => @business_index.id))
    else
      @title = pat(:create_title, :model => 'business_index')
      flash.now[:error] = pat(:create_error, :model => 'business_index')
      render 'business_indices/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "business_index #{params[:id]}")
    @business_index = BusinessIndex.find(params[:id])
    if @business_index
      render 'business_indices/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'business_index', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "business_index #{params[:id]}")
    @business_index = BusinessIndex.find(params[:id])
    if @business_index
      if @business_index.update_attributes(params[:business_index])
        flash[:success] = pat(:update_success, :model => 'Business_index', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:business_indices, :index)) :
          redirect(url(:business_indices, :edit, :id => @business_index.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'business_index')
        render 'business_indices/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'business_index', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Business_indices"
    business_index = BusinessIndex.find(params[:id])
    if business_index
      if business_index.destroy
        flash[:success] = pat(:delete_success, :model => 'Business_index', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'business_index')
      end
      redirect url(:business_indices, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'business_index', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Business_indices"
    unless params[:business_index_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'business_index')
      redirect(url(:business_indices, :index))
    end
    ids = params[:business_index_ids].split(',').map(&:strip)
    business_indices = BusinessIndex.find(ids)
    
    if BusinessIndex.destroy business_indices
    
      flash[:success] = pat(:destroy_many_success, :model => 'Business_indices', :ids => "#{ids.join(', ')}")
    end
    redirect url(:business_indices, :index)
  end
end
