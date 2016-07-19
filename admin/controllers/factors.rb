Econaider::Admin.controllers :factors do
  get :index do
    @title = "Factors"
    @factors = Factor.all
    render 'factors/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'factor')
    @factor = Factor.new
    render 'factors/new'
  end

  post :create do
    @factor = Factor.new(params[:factor])
    if @factor.save
      @title = pat(:create_title, :model => "factor #{@factor.id}")
      flash[:success] = pat(:create_success, :model => 'Factor')
      params[:save_and_continue] ? redirect(url(:factors, :index)) : redirect(url(:factors, :edit, :id => @factor.id))
    else
      @title = pat(:create_title, :model => 'factor')
      flash.now[:error] = pat(:create_error, :model => 'factor')
      render 'factors/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "factor #{params[:id]}")
    @factor = Factor.find(params[:id])
    if @factor
      render 'factors/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'factor', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "factor #{params[:id]}")
    @factor = Factor.find(params[:id])
    if @factor
      if @factor.update_attributes(params[:factor])
        flash[:success] = pat(:update_success, :model => 'Factor', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:factors, :index)) :
          redirect(url(:factors, :edit, :id => @factor.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'factor')
        render 'factors/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'factor', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Factors"
    factor = Factor.find(params[:id])
    if factor
      if factor.destroy
        flash[:success] = pat(:delete_success, :model => 'Factor', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'factor')
      end
      redirect url(:factors, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'factor', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Factors"
    unless params[:factor_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'factor')
      redirect(url(:factors, :index))
    end
    ids = params[:factor_ids].split(',').map(&:strip)
    factors = Factor.find(ids)
    
    if Factor.destroy factors
    
      flash[:success] = pat(:destroy_many_success, :model => 'Factors', :ids => "#{ids.join(', ')}")
    end
    redirect url(:factors, :index)
  end
end
