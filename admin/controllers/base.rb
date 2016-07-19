Econaider::Admin.controllers :base do
  get :index, :map => "/" do
    render "base/index"
  end

  get :to_do_list, :map => '/to_do_list' do 
  	render "base/features"
  end
end
