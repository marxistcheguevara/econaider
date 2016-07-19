Econaider::Admin.controllers :needs do
  get :index do
    @title = "Needs"
    @needs = Need.all
    render 'needs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'need')
    @lines = Line.all.map{|cat| [cat.name, cat.id]}
    @need = Need.new
    render 'needs/new'
  end

  post :create do
    @need = Need.new(params[:need])
    if @need.save
      @title = pat(:create_title, :model => "need #{@need.id}")
      flash[:success] = pat(:create_success, :model => 'Need')
      params[:save_and_continue] ? redirect(url(:needs, :index)) : redirect(url(:needs, :edit, :id => @need.id))
    else
      @title = pat(:create_title, :model => 'need')
      flash.now[:error] = pat(:create_error, :model => 'need')
      render 'needs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "need #{params[:id]}")
    @lines = Line.all.map{|cat| [cat.name, cat.id]} 
    @need = Need.find(params[:id])
    if @need
      render 'needs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'need', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "need #{params[:id]}")
    @need = Need.find(params[:id])
    if @need
      if @need.update_attributes(params[:need])
        flash[:success] = pat(:update_success, :model => 'Need', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:needs, :index)) :
          redirect(url(:needs, :edit, :id => @need.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'need')
        render 'needs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'need', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Needs"
    need = Need.find(params[:id])
    if need
      if need.destroy
        flash[:success] = pat(:delete_success, :model => 'Need', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'need')
      end
      redirect url(:needs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'need', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Needs"
    unless params[:need_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'need')
      redirect(url(:needs, :index))
    end
    ids = params[:need_ids].split(',').map(&:strip)
    needs = Need.find(ids)
    
    if Need.destroy needs
    
      flash[:success] = pat(:destroy_many_success, :model => 'Needs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:needs, :index)
  end
end
